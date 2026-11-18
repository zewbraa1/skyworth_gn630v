do_attach_ubi() {
	case "$(board_name)" in
	skyworth,gn630v)
		ubiattach -p /dev/mtd4 2>/dev/null || true
		;;
	esac
}

boot_hook_add preinit_main do_attach_ubi
