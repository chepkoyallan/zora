from zoracloud.pipeline.pipelines import BeamPipeline
from apache_beam import Create, Map
import tensorflow as tf
import apache_beam as beam
import tempfile
from pprint import pprint as pp
from tensorflow_transform.tf_metadata import dataset_metadata
from tensorflow_transform.tf_metadata import schema_utils
import tensorflow_transform as tft
import tensorflow_transform.beam.impl as tft_beam


pipe_line_inst = BeamPipeline()

pipeline = pipe_line_inst.create_pipeline()


class NumericColumnStatistics(BeamPipeline):
    def __init__(self, data_location):
        super().__init__()
        self.data = data_location

    @staticmethod
    def preprocessing_fn(inputs):
        x = inputs['x']
        x_normalized = tft.scale_to_0_1(x)
        return {
            'x_xf': x_normalized
        }

    def generate(self):

        raw_data = [{"x": 1.20}, {"x": 2.99}, {"x": 100.00}]

        raw_metadata = dataset_metadata.DatasetMetadata(
            schema=schema_utils.schema_from_feature_spec(
                {
                    "x": tf.io.FixedLenFeature([], tf.float32),
                }
            )
        )

        with self.create_pipeline() as pipeline:
            temp_dir=tempfile.mkdtemp()
            with tft_beam.Context(temp_dir="/Users/allan.chepkoy/cloud/rflow_libs/zora/data/transformed_functions"):
                tfrecord_file = "/Users/allan.chepkoy/cloud/rflow_libs/zora/data/tf_record_file.tfrecord"
                # raw_data = (
                #     pipeline | beam.io.ReadFromTFRecord(tfrecord_file)
                # )

                transformed_dataset, transformed_fn = (
                    (raw_data, raw_metadata) | tft_beam.AnalyzeAndTransformDataset(self.preprocessing_fn)
                )


if __name__ == "__main__":
    NumericColumnStatistics("here").generate()
