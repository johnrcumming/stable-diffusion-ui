#
# utility functions for all scripts
#

fail() {
    echo
    echo "EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE"
    echo
    if [ "$1" != "" ]; then
        echo ERROR: $1
    else
        echo An error occurred.
    fi
    cat <<EOF

Error downloading Stable Diffusion UI. Sorry about that, please try to:
 1. Run this installer again.
 2. If that doesn't fix it, please try the common troubleshooting steps at https://github.com/cmdr2/stable-diffusion-ui/wiki/Troubleshooting
 3. If those steps don't help, please copy *all* the error messages in this window, and ask the community at https://discord.com/invite/u9yhsFmEkB
 4. If that doesn't solve the problem, please file an issue at https://github.com/cmdr2/stable-diffusion-ui/issues

Thanks!


EOF
    read -p "Press any key to continue"
    exit 1

}

filesize() {
    case "$(uname -s)" in
        Linux*)     stat -c "%s" $1;;
        Darwin*)    stat -f "%z" $1;;
        *)          echo "Unknown OS: $OS_NAME! This script runs only on Linux or Mac" && exit
    esac
}


download_model() {
    # $1 URL
    # $2 Target
    # $3 size in bytes

    if [ ! -f "$2" ]; then
        echo "Downloading data files (weights) for Stable Diffusion.."

        curl -L -k $1 > $2

        if [ -f "$2" ]; then
            model_size=`filesize "$2"`
            if [ ! "$model_size" == "$3" ]; then
            fail "The downloaded model file was invalid! Bytes downloaded: $model_size"
            fi
        else
            fail "Error downloading the data files (weights) for Stable Diffusion"
        fi
    fi
}
