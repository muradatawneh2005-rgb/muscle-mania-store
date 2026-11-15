"""Products endpoints. Phase 2: documented stubs that answer 501 until their sprint (see Jira)."""
from fastapi import APIRouter, HTTPException

router = APIRouter(prefix='', tags=['products'])


@router.get('/categories')
def get_1():
    """FR-04 category tree"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-04 category tree')


@router.get('/products')
def get_2():
    """FR-04/FR-05 list, search, filter"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-04/FR-05 list, search, filter')


@router.get('/products/{slug}')
def get_3():
    """FR-06 product detail"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-06 product detail')


@router.post('/products/{product_id}/reviews')
def post_4():
    """FR-14 review"""
    raise HTTPException(status_code=501, detail='Not implemented yet: FR-14 review')
