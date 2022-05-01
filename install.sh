_CWD=$(pwd)

sudo apt-get update
sudo apt-get install -y openjdk-11-jdk-headless
sudo apt-get install -y git
sudo apt-get install -y cmake
sudo apt-get install -y build-essential
sudo apt-get install -y libgcrypt20-dev
sudo apt-get install -y libyajl-dev
sudo apt-get install -y libboost-all-dev
sudo apt-get install -y libcurl4-openssl-dev
sudo apt-get install -y libexpat1-dev
sudo apt-get install -y libcppunit-dev
sudo apt-get install -y binutils-dev
sudo apt-get install -y debhelper
sudo apt-get install -y zlib1g-dev
sudo apt-get install -y dpkg-dev
sudo apt-get install -y pkg-config

git clone https://github.com/vitalif/grive2.git _grive
cd _grive && dpkg-buildpackage -j4 --no-sign
cd $_CWD
rm -rf grive*
mv _grive grive
