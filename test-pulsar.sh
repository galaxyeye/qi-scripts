#bin

PULSAR_HOME=$HOME/workspace/pulsar
EXOTIC_HOME=$HOME/workspace/exotic

cd "$PULSAR_HOME" && mvn clean && mvn
cd "$EXOTIC_HOME" && mvn clean && mvn -skipTests=true
