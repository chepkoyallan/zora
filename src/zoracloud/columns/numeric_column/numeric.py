import tensorflow as tf
from tensorflow import feature_column
from typing import Dict


class NumericFeautureColumn:
    """Numeric feature column"""

    def __init__(self, data, column_name, tensor_shape):
        self.default_value = None
        self.dtype = tf.dtypes.float32
        self.normalizer_fn = None
        self.data = data
        self.key = column_name

    def process_numeric_coulumn(self):
        pass

    def generate_buckets(self):
        pass
