"""add customers date_of_birth

Revision ID: 459d1b32c308
Revises: 0d9ccadb8cbf
Create Date: 2023-01-09 14:03:47.989327

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '459d1b32c308'
down_revision = '0d9ccadb8cbf'
branch_labels = None
depends_on = None


def upgrade():
    op.execute(
        """
        ALTER TABLE customers
        ADD COLUMN date_of_birth TIMESTAMP;
        """
    )   


def downgrade():
    op.execute(
        """
        ALTER TABLE customers
        DROP COLUMN date_of_birth;
        """
    )
