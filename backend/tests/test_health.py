from fastapi.testclient import TestClient
from app.main import app


def test_health():
    assert TestClient(app).get('/api/v1/health').json() == {'status': 'ok'}


def test_stub_answers_501():
    assert TestClient(app).post('/api/v1/orders').status_code == 501
