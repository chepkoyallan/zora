install:
	python setup.py install

templates:
	rflow init list

create:
	 rflow projects init --pipeline_name allan --destination_path . --model preprocessing
