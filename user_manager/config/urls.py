from grpc_utils.user_proto_code import user_pb2_grpc
from users.services import UserService

urlpatterns = []


def grpc_handlers(server):
    user_pb2_grpc.add_UserControllerServicer_to_server(UserService.as_servicer(), server)
