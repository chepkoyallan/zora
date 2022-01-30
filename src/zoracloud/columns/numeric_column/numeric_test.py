import tensorflow as tf

data = {
    "a": [15, 9, 17, 19, 21, 18, 25, 30],
    "b": [5.0, 6.4, 10.5, 13.6, 15.7, 19.9, 20.3, 0.0],
}

tf.feature_column.numeric_column(
    key="a", shape=(1,), default_value=None, dtype=tf.dtypes.float32, normalizer_fn=None
)

a = tf.feature_column.numeric_column("a")
b = tf.feature_column.numeric_column("b")


a_buckets = tf.feature_column.bucketized_column(a, boundaries=[10, 15, 20, 25, 30])
feature_layer = tf.keras.layers.DenseFeatures([a_buckets, b])
print(feature_layer(data))
