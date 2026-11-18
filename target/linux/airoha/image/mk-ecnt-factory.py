cat << 'EOF' > ~/skyworth_gn630v/target/linux/airoha/image/mk-ecnt-factory.py
#!/usr/bin/env python3
import os
import struct
import subprocess
import sys
import zlib

kern_hdr2, dtb_path, root_path, mkimage, out_path = sys.argv[1:]

raw_fit = open(kern_hdr2, "rb").read()[0x100:]
gz_buf = raw_fit[raw_fit.find(b"\x1f\x8b\x08"):]
d = zlib.decompressobj(16 + zlib.MAX_WBITS)
d.decompress(gz_buf)
k_gz_bytes = gz_buf[:len(gz_buf) - len(d.unused_data)]

k_gz = out_path + ".gz"
its_path = out_path + ".its"
itb_path = out_path + ".itb"
pad_file = out_path + ".pad"

open(k_gz, "wb").write(k_gz_bytes)

def build_itb(pad_bytes):
    open(pad_file, "wb").write(b"\xff" * pad_bytes)
    pad_node = ""
    if pad_bytes > 0:
        pad_node = f'''
        pad@1 {{
            description = "Padding";
            data = /incbin/("{pad_file}");
            type = "firmware";
            compression = "none";
        }};'''

    its = f'''/dts-v1/;
/ {{
    description = "Kernel image with single Linux kernel, rootfs and FDT blob for Skyworth";
    #address-cells = <1>;
    images {{
        fdt@1 {{
            description = "ECONET Flattened Device Tree blob";
            data = /incbin/("{dtb_path}");
            type = "flat_dt";
            arch = "arm";
            compression = "none";
            hash@1 {{ algo = "sha1"; }};
        }};
        kernel@1 {{
            description = "ECONET Linux kernel";
            data = /incbin/("{k_gz}");
            type = "kernel";
            arch = "arm";
            os = "linux";
            compression = "gzip";
            load = <0x80208000>;
            entry = <0x80208000>;
            hash@1 {{ algo = "sha1"; }};
        }};{pad_node}
        filesystem@1 {{
            description = "ECONET Root File System";
            data = /incbin/("{root_path}");
            type = "filesystem";
            compression = "none";
            hash@1 {{ algo = "sha1"; }};
        }};
    }};
    configurations {{
        default = "conf@1";
        conf@1 {{
            description = "Boot Linux kernel with FDT blob";
            kernel = "kernel@1";
            fdt = "fdt@1";
        }};
    }};
}};
'''
    open(its_path, "w").write(its)
    subprocess.run([mkimage, "-f", its_path, itb_path], check=True)
    return open(itb_path, "rb").read()

itb0 = build_itb(0)
root = open(root_path, "rb").read()
fs_off = itb0.find(root[:64])
pad_needed = 0x600000 - (0x100 + fs_off)
itb = build_itb(pad_needed)

crc = (~zlib.crc32(itb)) & 0xffffffff
hdr = struct.pack(
    "<4sIII32s32sIII32s132x",
    b"HDR2",
    0x100,
    len(itb) + 0x100,
    crc,
    b"7.3.267.700_v013\n",
    b"V1.0.0.1\n",
    len(k_gz_bytes),
    len(root),
    0,
    b"EN7523,GN630\n",
)
open(out_path, "wb").write(hdr + itb)
EOF
chmod +x ~/skyworth_gn630v/target/linux/airoha/image/mk-ecnt-factory.py
