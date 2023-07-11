#!/bin/bash

# python src/inference.py --dataset [dresscode | vitonhd] --dresscode_dataroot <path> --vitonhd_dataroot <path> --output_dir <path> --test_order [paired | unpaired] --category [all | lower_body | upper_body | dresses ] --batch_size <int> --mixed_precision [no | fp16 | bf16] --enable_xformers_memory_efficient_attention <store_true> --num_workers <int>  --use_png <store_true> --compute_metrics <store_true>

python src/inference.py --dataset vitonhd --vitonhd_dataroot zalando-hd-resized --output_dir result --test_order paired --category upper_body  --batch_size 4 --mixed_precision no --num_workers 8  --use_png