"""Sia Node

Revision ID: f7ef6c6787fe
Revises: 
Create Date: 2019-02-26 11:59:49.484171

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = 'f7ef6c6787fe'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('sia_node',
    sa.Column('id', sa.String(), nullable=False),
    sa.Column('accepting_contracts', sa.Boolean(), nullable=True),
    sa.Column('max_download_batch_size', sa.Integer(), nullable=True),
    sa.Column('max_duration', sa.Integer(), nullable=True),
    sa.Column('max_revise_batch_size', sa.Integer(), nullable=True),
    sa.Column('net_address', sa.String(), nullable=True),
    sa.Column('remaining_storage', sa.Integer(), nullable=True),
    sa.Column('sector_size', sa.Integer(), nullable=True),
    sa.Column('total_storage', sa.Integer(), nullable=True),
    sa.Column('unlock_hash', sa.String(), nullable=True),
    sa.Column('window_size', sa.Integer(), nullable=True),
    sa.Column('collateral', sa.String(), nullable=True),
    sa.Column('max_collateral', sa.String(), nullable=True),
    sa.Column('contract_price', sa.String(), nullable=True),
    sa.Column('download_bandwidth_price', sa.String(), nullable=True),
    sa.Column('storage_price', sa.String(), nullable=True),
    sa.Column('upload_bandwidth_price', sa.String(), nullable=True),
    sa.Column('revision_number', sa.Integer(), nullable=True),
    sa.Column('version', sa.String(), nullable=True),
    sa.Column('first_seen', sa.Integer(), nullable=True),
    sa.Column('historic_downtime', sa.Integer(), nullable=True),
    sa.Column('historic_uptime', sa.Integer(), nullable=True),
    sa.Column('historic_failed_interactions', sa.Integer(), nullable=True),
    sa.Column('historic_successful_interactions', sa.Integer(), nullable=True),
    sa.Column('recent_failed_interactions', sa.Integer(), nullable=True),
    sa.Column('recent_successful_interactions', sa.Integer(), nullable=True),
    sa.Column('last_historic_update', sa.Integer(), nullable=True),
    sa.Column('public_key_string', sa.String(), nullable=True),
    sa.Column('ipnets', postgresql.ARRAY(postgresql.INET()), nullable=True),
    sa.Column('address', sa.String(), nullable=True),
    sa.Column('country', sa.String(), nullable=True),
    sa.Column('city', sa.String(), nullable=True),
    sa.Column('latitude', sa.Float(), nullable=True),
    sa.Column('longitude', sa.Float(), nullable=True),
    sa.PrimaryKeyConstraint('id')
    )
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('sia_node')
    # ### end Alembic commands ###