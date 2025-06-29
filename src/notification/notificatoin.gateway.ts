import {
  WebSocketGateway,
  WebSocketServer,
  OnGatewayConnection,
  OnGatewayDisconnect,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';

@WebSocketGateway({
  cors: { origin: '*' },
})
export class NotificationsGateway
  implements OnGatewayConnection, OnGatewayDisconnect
{
  @WebSocketServer()
  server: Server;

  handleConnection(client: Socket) {
    console.log(`Admin connected: ${client.id}`);
  }

  handleDisconnect(client: Socket) {
    console.log(`Admin disconnected: ${client.id}`);
  }

  // ✅ Send to ALL connected clients (broadcast)
  notifyAllAdmins(notification: any) {
    this.server.emit('new-notification', notification);
  }
}
