#! /bin/sh

# prepares crypto_key.h file to feed SD Card Bootloader
# with XXTEA key in expected form.

key_to_array()
{
	file="$1"
	echo -n "0x"
	cut --output-delimiter=", 0x" -c1-8,9-16,17-24,25-32 < $file
}

xxtea_key_convert()
{
	echo "{"`key_to_array $1`"}"
}

gen_crypto_header_file()
{
	header="$1"
	keyfile="$2"

	echo "#ifndef CRYPTO_KEY_H_"       >  $header
	echo "#define CRYPTO_KEY_H_"       >> $header
	echo "#define XXTEA_KEY "`xxtea_key_convert $keyfile` >> $header
	echo "#endif /* CRYPTO_KEY_H_ */ " >> $header
}

if [ -z "$1" ]; then
	echo "Missing file to write the generated content to" >&2
	exit 1
fi

if [ -z "$2" ]; then
	echo "Missing file to read XXTEA key from" >&2
	exit 2
fi

gen_crypto_header_file "$1" "$2"
