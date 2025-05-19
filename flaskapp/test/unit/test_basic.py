from app import create_app
import pytest

@pytest.fixture
def client():
    app = create_app()
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_healthcheck(client):
    rv = client.get('/healthcheck')
    assert rv.status_code == 200
    assert b'ok' in rv.data