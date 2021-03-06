#!/bin/bash

source ../../../setup_viame.sh

mkdir -p database/ITQ

SMQTK_ITQ_TRAIN_CONFIG="configs/smqtk_train_itq.json"
SMQTK_ITQ_BIT_SIZE=256

SMQTK_HCODE_CONFIG="configs/smqtk_compute_hashes.json"
SMQTK_HCODE_PICKLE="database/ITQ/alexnet_fc7.itq_b256_i50_n2_r0.lsh_hash2uuids.pickle"

SMQTK_HCODE_BTREE_LEAFSIZE=40
SMQTK_HCODE_BTREE_RAND=0
SMQTK_HCODE_BTREE_OUTPUT="database/ITQ/alexnet_fc7.itq_b256_i50_n2_r0.hi_btree.npz"

# Train ITQ models on ingested descriptors
train_itq -vc "${SMQTK_ITQ_TRAIN_CONFIG}"

# Compute hash codes for descriptors
compute_hash_codes \
    -vc "${SMQTK_HCODE_CONFIG}" \
    --output-hash2uuids "${SMQTK_HCODE_PICKLE}"

# Compute balltree hash index
make_balltree "${SMQTK_HCODE_PICKLE}" ${SMQTK_ITQ_BIT_SIZE} \
    ${SMQTK_HCODE_BTREE_LEAFSIZE} ${SMQTK_HCODE_BTREE_RAND} \
    ${SMQTK_HCODE_BTREE_OUTPUT}
