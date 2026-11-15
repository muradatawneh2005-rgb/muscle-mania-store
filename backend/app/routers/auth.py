"""Auth endpoints. Phase 2: documented stubs that answer 501 until their sprint (see Jira)."""
from fastapi import APIRouter, HTTPException

router = APIRouter(prefix='/auth', tags=['auth'])


@router.post('/register')
def post_1():
    """FR-01 register"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-01 register')


@router.post('/login')
def post_2():
    """FR-02 log in"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-02 log in')


@router.post('/logout')
def post_3():
    """FR-02 log out"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-02 log out')


@router.post('/password-reset')
def post_4():
    """FR-03 reset password"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-03 reset password')
