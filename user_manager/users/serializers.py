from .models import User
from django_grpc_framework import proto_serializers
from grpc_utils.user_proto_code import user_pb2


class UserProtoSerializer(proto_serializers.ModelProtoSerializer):
    class Meta:
        model = User
        proto_class = user_pb2.User
        fields = ['id', 'username', 'email', 'first_name', 'last_name']
