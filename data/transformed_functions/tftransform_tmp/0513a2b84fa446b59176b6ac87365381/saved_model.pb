?\
??
h
All	
input

reduction_indices"Tidx

output
"
	keep_dimsbool( "
Tidxtype0:
2	
P
Assert
	condition
	
data2T"
T
list(type)(0"
	summarizeint?
8
Const
output"dtype"
valuetensor"
dtypetype
R
Equal
x"T
y"T
z
"	
Ttype"$
incompatible_shape_errorbool(?
.
Identity

input"T
output"T"	
Ttype
?
Max

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( " 
Ttype:
2	"
Tidxtype0:
2	
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(?

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0?
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0?
?
Select
	condition

t"T
e"T
output"T"	
Ttype
H
ShardedFilename
basename	
shard

num_shards
filename
?
StatefulPartitionedCall
args2Tin
output2Tout"
Tin
list(type)("
Tout
list(type)("	
ffunc"
configstring "
config_protostring "
executor_typestring ??
@
StaticRegexFullMatch	
input

output
"
patternstring
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
<
Sub
x"T
y"T
z"T"
Ttype:
2	
&
	ZerosLike
x"T
y"T"	
Ttype"serve*2.7.02v2.7.0-rc1-69-gc256c071bb28?C

NoOpNoOp
?
ConstConst"/device:CPU:0*
_output_shapes
: *
dtype0*?
value?B By
k
created_variables
	resources
trackable_objects
initializers

assets

signatures
 
 
 
 
 
 
q
serving_default_inputsPlaceholder*#
_output_shapes
:?????????*
dtype0*
shape:?????????
?
StatefulPartitionedCallStatefulPartitionedCallserving_default_inputs*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: : * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? **
f%R#
!__inference_signature_wrapper_170
O
saver_filenamePlaceholder*
_output_shapes
: *
dtype0*
shape: 
?
StatefulPartitionedCall_1StatefulPartitionedCallsaver_filenameConst*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *%
f R
__inference__traced_save_194
?
StatefulPartitionedCall_2StatefulPartitionedCallsaver_filename*
Tin
2*
Tout
2*
_collective_manager_ids
 *
_output_shapes
: * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *(
f#R!
__inference__traced_restore_204?9
?
i
__inference__traced_save_194
file_prefix
savev2_const

identity_1??MergeV2Checkpointsw
StaticRegexFullMatchStaticRegexFullMatchfile_prefix"/device:CPU:**
_output_shapes
: *
pattern
^s3://.*Z
ConstConst"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B.parta
Const_1Const"/device:CPU:**
_output_shapes
: *
dtype0*
valueB B
_temp/part?
SelectSelectStaticRegexFullMatch:output:0Const:output:0Const_1:output:0"/device:CPU:**
T0*
_output_shapes
: f

StringJoin
StringJoinfile_prefixSelect:output:0"/device:CPU:**
N*
_output_shapes
: L

num_shardsConst*
_output_shapes
: *
dtype0*
value	B :f
ShardedFilename/shardConst"/device:CPU:0*
_output_shapes
: *
dtype0*
value	B : ?
ShardedFilenameShardedFilenameStringJoin:output:0ShardedFilename/shard:output:0num_shards:output:0"/device:CPU:0*
_output_shapes
: ?
SaveV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*1
value(B&B_CHECKPOINTABLE_OBJECT_GRAPHo
SaveV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueB
B ?
SaveV2SaveV2ShardedFilename:filename:0SaveV2/tensor_names:output:0 SaveV2/shape_and_slices:output:0savev2_const"/device:CPU:0*
_output_shapes
 *
dtypes
2?
&MergeV2Checkpoints/checkpoint_prefixesPackShardedFilename:filename:0^SaveV2"/device:CPU:0*
N*
T0*
_output_shapes
:?
MergeV2CheckpointsMergeV2Checkpoints/MergeV2Checkpoints/checkpoint_prefixes:output:0file_prefix"/device:CPU:0*
_output_shapes
 f
IdentityIdentityfile_prefix^MergeV2Checkpoints"/device:CPU:0*
T0*
_output_shapes
: Q

Identity_1IdentityIdentity:output:0^NoOp*
T0*
_output_shapes
: [
NoOpNoOp^MergeV2Checkpoints*"
_acd_function_control_output(*
_output_shapes
 "!

identity_1Identity_1:output:0*
_input_shapes
: : 2(
MergeV2CheckpointsMergeV2Checkpoints:C ?

_output_shapes
: 
%
_user_specified_namefile_prefix:

_output_shapes
: 
?
E
__inference_pruned_161

inputs
identity

identity_1?M
inputs_copyIdentityinputs*
T0*#
_output_shapes
:?????????t
#scale_to_0_1/min_and_max/zeros_like	ZerosLikeinputs_copy:output:0*
T0*#
_output_shapes
:??????????
scale_to_0_1/min_and_max/subSub'scale_to_0_1/min_and_max/zeros_like:y:0inputs_copy:output:0*
T0*#
_output_shapes
:?????????j
 scale_to_0_1/min_and_max/Const_1Const*
_output_shapes
:*
dtype0*
valueB: ?
scale_to_0_1/min_and_max/Max_1Max scale_to_0_1/min_and_max/sub:z:0)scale_to_0_1/min_and_max/Const_1:output:0*
T0*
_output_shapes
: a
scale_to_0_1/min_and_max/ShapeConst*
_output_shapes
: *
dtype0*
valueB c
 scale_to_0_1/min_and_max/Shape_1Const*
_output_shapes
: *
dtype0*
valueB ?
-scale_to_0_1/min_and_max/assert_equal_1/EqualEqual'scale_to_0_1/min_and_max/Shape:output:0)scale_to_0_1/min_and_max/Shape_1:output:0*
T0*
_output_shapes
: w
-scale_to_0_1/min_and_max/assert_equal_1/ConstConst*
_output_shapes
:*
dtype0*
valueB: ?
+scale_to_0_1/min_and_max/assert_equal_1/AllAll1scale_to_0_1/min_and_max/assert_equal_1/Equal:z:06scale_to_0_1/min_and_max/assert_equal_1/Const:output:0*
_output_shapes
: ?
<scale_to_0_1/min_and_max/assert_equal_1/Assert/Assert/data_0Const*
_output_shapes
: *
dtype0*<
value3B1 B+Condition x == y did not hold element-wise:?
<scale_to_0_1/min_and_max/assert_equal_1/Assert/Assert/data_1Const*
_output_shapes
: *
dtype0*8
value/B- B'x (scale_to_0_1/min_and_max/Shape:0) = ?
<scale_to_0_1/min_and_max/assert_equal_1/Assert/Assert/data_3Const*
_output_shapes
: *
dtype0*:
value1B/ B)y (scale_to_0_1/min_and_max/Shape_1:0) = ?
5scale_to_0_1/min_and_max/assert_equal_1/Assert/AssertAssert4scale_to_0_1/min_and_max/assert_equal_1/All:output:0Escale_to_0_1/min_and_max/assert_equal_1/Assert/Assert/data_0:output:0Escale_to_0_1/min_and_max/assert_equal_1/Assert/Assert/data_1:output:0'scale_to_0_1/min_and_max/Shape:output:0Escale_to_0_1/min_and_max/assert_equal_1/Assert/Assert/data_3:output:0)scale_to_0_1/min_and_max/Shape_1:output:0*
T	
2*
_output_shapes
 ?
!scale_to_0_1/min_and_max/IdentityIdentity'scale_to_0_1/min_and_max/Max_1:output:06^scale_to_0_1/min_and_max/assert_equal_1/Assert/Assert*
T0*
_output_shapes
: ~
NoOpNoOp6^scale_to_0_1/min_and_max/assert_equal_1/Assert/Assert*"
_acd_function_control_output(*
_output_shapes
 h
IdentityIdentity*scale_to_0_1/min_and_max/Identity:output:0^NoOp*
T0*
_output_shapes
: h
scale_to_0_1/min_and_max/ConstConst*
_output_shapes
:*
dtype0*
valueB: ?
scale_to_0_1/min_and_max/MaxMaxinputs_copy:output:0'scale_to_0_1/min_and_max/Const:output:0*
T0*
_output_shapes
: ?
#scale_to_0_1/min_and_max/Identity_1Identity%scale_to_0_1/min_and_max/Max:output:06^scale_to_0_1/min_and_max/assert_equal_1/Assert/Assert*
T0*
_output_shapes
: l

Identity_1Identity,scale_to_0_1/min_and_max/Identity_1:output:0^NoOp*
T0*
_output_shapes
: "
identityIdentity:output:0"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*"
_input_shapes
:?????????:) %
#
_output_shapes
:?????????
?
j
!__inference_signature_wrapper_170

inputs
identity

identity_1??StatefulPartitionedCall?
StatefulPartitionedCallStatefulPartitionedCallinputs*
Tin
2*
Tout
2*
_output_shapes
: : * 
_read_only_resource_inputs
 *-
config_proto

CPU

GPU 2J 8? *
fR
__inference_pruned_161^
IdentityIdentity StatefulPartitionedCall:output:0^NoOp*
T0*
_output_shapes
: `

Identity_1Identity StatefulPartitionedCall:output:1^NoOp*
T0*
_output_shapes
: `
NoOpNoOp^StatefulPartitionedCall*"
_acd_function_control_output(*
_output_shapes
 "
identityIdentity:output:0"!

identity_1Identity_1:output:0*(
_construction_contextkEagerRuntime*"
_input_shapes
:?????????22
StatefulPartitionedCallStatefulPartitionedCall:K G
#
_output_shapes
:?????????
 
_user_specified_nameinputs
?
E
__inference__traced_restore_204
file_prefix

identity_1??
RestoreV2/tensor_namesConst"/device:CPU:0*
_output_shapes
:*
dtype0*1
value(B&B_CHECKPOINTABLE_OBJECT_GRAPHr
RestoreV2/shape_and_slicesConst"/device:CPU:0*
_output_shapes
:*
dtype0*
valueB
B ?
	RestoreV2	RestoreV2file_prefixRestoreV2/tensor_names:output:0#RestoreV2/shape_and_slices:output:0"/device:CPU:0*
_output_shapes
:*
dtypes
21
NoOpNoOp"/device:CPU:0*
_output_shapes
 X
IdentityIdentityfile_prefix^NoOp"/device:CPU:0*
T0*
_output_shapes
: J

Identity_1IdentityIdentity:output:0*
T0*
_output_shapes
: "!

identity_1Identity_1:output:0*
_input_shapes
: :C ?

_output_shapes
: 
%
_user_specified_namefile_prefix"?L
saver_filename:0StatefulPartitionedCall_1:0StatefulPartitionedCall_28"
saved_model_main_op

NoOp*>
__saved_model_init_op%#
__saved_model_init_op

NoOp*?
serving_default?
5
inputs+
serving_default_inputs:0?????????D
!scale_to_0_1/min_and_max/Identity
StatefulPartitionedCall:0 F
#scale_to_0_1/min_and_max/Identity_1
StatefulPartitionedCall:1 tensorflow/serving/predict:?
?
created_variables
	resources
trackable_objects
initializers

assets

signatures
transform_fn"
_generic_user_object
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
 "
trackable_list_wrapper
,
serving_default"
signature_map
$B"
__inference_pruned_161inputs
?B?
!__inference_signature_wrapper_170inputs"?
???
FullArgSpec
args? 
varargs
 
varkwjkwargs
defaults
 

kwonlyargs? 
kwonlydefaults
 
annotations? *
 ?
__inference_pruned_161?7?4
-?*
(?%
#
x?
inputs/x?????????
? "???
O
!scale_to_0_1/min_and_max/Identity*?'
!scale_to_0_1/min_and_max/Identity 
S
#scale_to_0_1/min_and_max/Identity_1,?)
#scale_to_0_1/min_and_max/Identity_1 ?
!__inference_signature_wrapper_170?5?2
? 
+?(
&
inputs?
inputs?????????"???
O
!scale_to_0_1/min_and_max/Identity*?'
!scale_to_0_1/min_and_max/Identity 
S
#scale_to_0_1/min_and_max/Identity_1,?)
#scale_to_0_1/min_and_max/Identity_1 