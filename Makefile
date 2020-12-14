iso:bootloader
	truncate ./bootloader.bin -s 1200k
	mkisofs -o os.iso -b bootloader.bin .
bootloader:
	nasm -fbin ./bootloader.asm -o ./bootloader.bin
test-bootloader:bootloader
	qemu-system-x86_64 ./bootloader.bin
git-up:
	git add -A
	git commit -am "-"
	git push
git-down:
	git pull
