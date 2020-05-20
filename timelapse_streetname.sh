

mkdir texted
mkdir videoframes
ls -d *.JPG | parallel  convert -crop 4608x2592+0+0  "{}" "videoframes/{}"

ls -d videoframes/*.JPG | parallel ./print_streetname.sh {}

