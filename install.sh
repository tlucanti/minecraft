
sudo apt-get update
sudo apt-get install -y openjdk-11-jdk-headless
sudo apt-get install -y git
sudo apt-get install -y openjdk-17-jdk-headless

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export PATH=$PATH:$JAVA_HOME/bin

