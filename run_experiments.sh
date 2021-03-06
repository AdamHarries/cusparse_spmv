#/bin/sh

datasetf=$1
echo "Dataset folder: $datasetf"

spmv=$2
echo "SparseMatrixDenseVector excutable: $spmv"

table=$3
echo "Table name: $table"

# Get some unique data for the experiment ID
now=$(date -Iminutes)
hsh=$(git rev-parse HEAD)
exID="$hsh-$now"
host=$(hostname)

# make a folder for results
mkdir -p "results-$exID"

for f in $(cat $datasetf/datasets.txt);
do
	echo "matrix: $f"
	echo "Resultfile: result_$f.txt"

	$spmv $datasetf/$f/$f.mtx $f $host $exID $table &> results-$exID/result_$f.txt
done
