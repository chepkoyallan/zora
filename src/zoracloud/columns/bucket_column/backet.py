import tensorflow as tf


price = tf.feature_column.numeric_column("price")

bucketized_price = tf.feature_column.bucketized_column(price, boundaries=[...])

columns = [bucketized_price, ...]
features = tf.io.parse_example(
    ..., features=tf.feature_column.make_parse_example_spec(columns)
)

dense_tensor = tf.keras.layers.DenseFeatures(columns)(features)
