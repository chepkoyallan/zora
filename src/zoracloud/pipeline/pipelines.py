import apache_beam as beam
from apache_beam.options.pipeline_options import PipelineOptions


class BeamPipeline:
    def __init__(self, sdk_worker_parallelism=2, streaming=False, runner=None):
        # self.job_name = job_name
        self.sdk_worker_parallelism = sdk_worker_parallelism
        self.streaming = streaming
        self.runner = runner

    def __generate_args(self):
        args = ["--sdk_worker_parallelism={}".format(self.sdk_worker_parallelism)]

        return args

    def create_pipeline(self):
        pipeline = beam.Pipeline(options=PipelineOptions(self.__generate_args()))

        return pipeline
