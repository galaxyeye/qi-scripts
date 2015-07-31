#bin 

cd ~/workspace/qiwur-xsimilarity-0.9.0-src
ant jar 
cp target/xsimilarity-0.9.0.jar ~/workspace/qiwur-scent-1.0.0-src/lib/
cd ~/workspace/qiwur-scent-1.0.0-src/lib
mv xsimilarity-0.9.0.jar org.qiwur.nlp.xsimilarity-0.9.0.jar
cd ..
./bin/project-repo
rm -r ~/.m2/repository/org/qiwur/nlp/xsimilarity/
cp -r repo/org/qiwur/nlp/xsimilarity ~/.m2/repository/org/qiwur/nlp/
echo "-------------"
ls -l ~/.m2/repository/org/qiwur/nlp/xsimilarity

