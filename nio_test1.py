import asyncio
import sys

from env_loader import load_env
from nio import AsyncClient


async def connect():
    env = load_env('.')
    server_name = env.get('SYNAPSE_SERVER_NAME')
    if not server_name:
        print('ERROR: "SYNAPSE_SERVER_NAME" not found in .env')
        sys.exit(-1)

    homeserver = f'https://{server_name}'

    user_name = env.get('ADMIN_USER_NAME')
    if not user_name:
        print('ERROR: "ADMIN_USER_NAME" not found in .env')
        sys.exit(-1)

    user_password = env.get('ADMIN_USER_PASSWORD')
    if not user_password:
        print('ERROR: "ADMIN_USER_PASSWORD" not found in .env')
        sys.exit(-1)

    maxtrix_id = f'@{user_name}:{server_name}'

    print(f'Connect {homeserver} with matrix ID: {maxtrix_id!r}...')

    client = AsyncClient(homeserver, maxtrix_id)

    await client.login(user_password)

    return client


async def main():
    client = await connect()

    rooms = await client.joined_rooms()
    print(f'Joined rooms: {rooms}')

    await client.room_send(
        room_id='!test:example.org',
        message_type='m.room.message',
        content={
            'msgtype': 'm.text',
            'body': 'Hello World'
        }
    )
    await client.close()


if __name__ == '__main__':
    asyncio.get_event_loop().run_until_complete(main())
