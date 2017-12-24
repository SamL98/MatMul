nasm -g -f macho64 -o "${1}.o" "${1}.asm"
OK=$?
if [ $OK -eq 0 ]
then
	ld -lc -macosx_version_min 10.13 -lSystem -o "$1" "${1}.o"
	OK=$?
fi
if [ $OK -eq 0 ]
then
	./"${1}"
fi
