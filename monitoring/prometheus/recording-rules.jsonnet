{
  groups: [
    {
      name: 'recording_rules',
      rules: [
        // Take the existing blob size and batch size metrics and
        // turn them into a single aggregated metric per operation.
        {
          expr: 'sum(irate(buildbarn_blobstore_blob_access_operations_blob_size_bytes_count{job="buildbarn"}[1m])) by (service, name, operation)',
          record: 'service_name_operation:buildbarn_blobstore_blob_access_operations_started:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_blob_access_operations_find_missing_batch_size_count{job="buildbarn"}[1m])) by (service, name)',
          labels: {
            operation: 'FindMissing',
          },
          record: 'service_name:buildbarn_blobstore_blob_access_operations_started:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_blob_access_operations_duration_seconds_bucket{job="buildbarn"}[1m])) by (service, name, le, operation)',
          record: 'service_le_name_operation:buildbarn_blobstore_blob_access_operations_duration_seconds_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_blob_access_operations_duration_seconds_count{job="buildbarn"}[1m])) by (grpc_code, service, name)',
          record: 'grpc_code_service_name:buildbarn_blobstore_blob_access_operations_duration_seconds_count:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_blob_access_operations_find_missing_batch_size_bucket{job="buildbarn"}[1m])) by (service, name, le)',
          record: 'service_le_name:buildbarn_blobstore_blob_access_operations_find_missing_batch_size_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_blob_access_operations_blob_size_bytes_bucket{job="buildbarn"}[1m])) by (service, name, le, operation)',
          record: 'service_le_name_operation:buildbarn_blobstore_blob_access_operations_blob_size_bytes_bucket:irate1m',
        },

        // Statistics on retention of centralized storage.
        {
          expr: 'min(time() - buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds{job="buildbarn",service="bb_storage"}) by (instance, name)',
          record: 'instance:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds',
        },
        {
          expr: 'min(instance:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds) by (instance, name)',
          record: 'instance:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds:min',
        },
        {
          expr: 'max(instance:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds) by (instance, name)',
          record: 'instance:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds:max',
        },
        {
          expr: 'min(instance:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds) by (instance, name)',
          record: 'instance:buildbarn_blobstore_old_new_current_location_blob_map_last_removed_old_block_insertion_time_seconds:min',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_hashing_key_location_map_get_attempts_count{job="buildbarn",service="bb_storage"}[1m])) by (name, outcome)',
          record: 'name_outcome:buildbarn_blobstore_hashing_key_location_map_get_attempts_count:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_hashing_key_location_map_get_too_many_attempts_total{job="buildbarn",service="bb_storage"}[1m])) by (name)',
          record: 'name:buildbarn_blobstore_hashing_key_location_map_get_too_many_attempts:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_hashing_key_location_map_get_attempts_bucket{job="buildbarn",service="bb_storage"}[1m])) by (le, name)',
          record: 'le_name:buildbarn_blobstore_hashing_key_location_map_get_attempts_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_hashing_key_location_map_put_ignored_invalid_total{job="buildbarn",service="bb_storage"}[1m])) by (name)',
          record: 'name:buildbarn_blobstore_hashing_key_location_map_put_ignored_invalid:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_hashing_key_location_map_put_iterations_count{job="buildbarn",service="bb_storage"}[1m])) by (name, outcome)',
          record: 'name_outcome:buildbarn_blobstore_hashing_key_location_map_put_iterations_count:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_hashing_key_location_map_put_too_many_iterations_total{job="buildbarn",service="bb_storage"}[1m])) by (name)',
          record: 'name:buildbarn_blobstore_hashing_key_location_map_put_too_many_iterations:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_blobstore_hashing_key_location_map_put_iterations_bucket{job="buildbarn",service="bb_storage"}[1m])) by (le, name)',
          record: 'le_name:buildbarn_blobstore_hashing_key_location_map_put_iterations_bucket:irate1m',
        },

        // Rate at which tasks are processed by the scheduler.
        {
          expr: 'sum(irate(buildbarn_builder_in_memory_build_queue_tasks_queued_total{job="buildbarn",service="bb_scheduler"}[1m])) by (instance_name, platform)',
          record: 'instance_name_platform:buildbarn_builder_in_memory_build_queue_tasks_queued:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_in_memory_build_queue_tasks_queued_duration_seconds_count{job="buildbarn",service="bb_scheduler"}[1m])) by (instance_name, platform)',
          record: 'instance_name_platform:buildbarn_builder_in_memory_build_queue_tasks_executing:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_in_memory_build_queue_tasks_executing_duration_seconds_count{job="buildbarn",service="bb_scheduler"}[1m])) by (grpc_code, instance_name, platform, result)',
          record: 'grpc_code_instance_name_platform_result:buildbarn_builder_in_memory_build_queue_tasks_completed:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_in_memory_build_queue_tasks_completed_duration_seconds_count{job="buildbarn",service="bb_scheduler"}[1m])) by (instance_name, platform)',
          record: 'instance_name_platform:buildbarn_builder_in_memory_build_queue_tasks_removed:irate1m',
        },

        // Subtract counters of consecutive scheduler stages to derive
        // how many tasks are in each of the stages.
        {
          expr: |||

            sum(buildbarn_builder_in_memory_build_queue_tasks_queued_total{job="buildbarn",service="bb_scheduler"}) by (instance_name, platform)
            -
            sum(buildbarn_builder_in_memory_build_queue_tasks_queued_duration_seconds_count{job="buildbarn",service="bb_scheduler"}) by (instance_name, platform)
          |||,
          record: 'instance_name_platform:buildbarn_builder_in_memory_build_queue_tasks_queued:sum',
        },
        {
          expr: |||

            sum(buildbarn_builder_in_memory_build_queue_tasks_queued_duration_seconds_count{job="buildbarn",service="bb_scheduler"}) by (instance_name, platform)
            -
            sum(buildbarn_builder_in_memory_build_queue_tasks_executing_duration_seconds_count{job="buildbarn",service="bb_scheduler"}) by (instance_name, platform)
          |||,
          record: 'instance_name_platform:buildbarn_builder_in_memory_build_queue_tasks_executing:sum',
        },
        {
          expr: |||
            sum(buildbarn_builder_in_memory_build_queue_tasks_executing_duration_seconds_count{job="buildbarn",service="bb_scheduler"}) by (instance_name, platform)
            -
            sum(buildbarn_builder_in_memory_build_queue_tasks_completed_duration_seconds_count{job="buildbarn",service="bb_scheduler"}) by (instance_name, platform)
          |||,
          record: 'instance_name_platform:buildbarn_builder_in_memory_build_queue_tasks_completed:sum',
        },

        // Duration of how long tasks remain in scheduler stages.

        {
          expr: 'sum(irate(buildbarn_builder_in_memory_build_queue_tasks_queued_duration_seconds_bucket{job="buildbarn",service="bb_scheduler"}[1m])) by (instance_name, le, platform)',
          record: 'instance_name_le_platform:buildbarn_builder_in_memory_build_queue_tasks_queued_duration_seconds_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_in_memory_build_queue_tasks_executing_duration_seconds_bucket{job="buildbarn",service="bb_scheduler"}[1m])) by (instance_name, le, platform)',
          record: 'instance_name_le_platform:buildbarn_builder_in_memory_build_queue_tasks_executing_duration_seconds_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_in_memory_build_queue_tasks_completed_duration_seconds_bucket{job="buildbarn",service="bb_scheduler"}[1m])) by (instance_name, le, platform)',
          record: 'instance_name_le_platform:buildbarn_builder_in_memory_build_queue_tasks_completed_duration_seconds_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_in_memory_build_queue_tasks_executing_retries_bucket{job="buildbarn",service="bb_scheduler"}[1m])) by (instance_name, le, platform)',
          record: 'instance_name_le_platform:buildbarn_builder_in_memory_build_queue_tasks_executing_retries_bucket:irate1m',
        },

        // Recording rules used by the "BuildExecutor" dashboard.
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_duration_seconds_count{job="buildbarn"}[1m])) by (service)',
          record: 'service:buildbarn_builder_build_executor_operations:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_duration_seconds_bucket{job="buildbarn"}[1m])) by (service, le, stage)',
          record: 'service_le_stage:buildbarn_builder_build_executor_duration_seconds_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_user_time_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_posix_user_time_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_system_time_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_posix_system_time_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_maximum_resident_set_size_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_posix_maximum_resident_set_size_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_maximum_resident_set_size_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_posix_maximum_resident_set_size_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_page_reclaims_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_posix_page_reclaims_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_page_faults_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_posix_page_faults_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_swaps_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_posix_swaps_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_block_input_operations_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_posix_block_input_operations_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_block_output_operations_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_posix_block_output_operations_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_messages_sent_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_posix_messages_sent_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_messages_received_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_posix_messages_received_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_signals_received_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_posix_signals_received_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_voluntary_context_switches_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_posix_voluntary_context_switches_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_posix_involuntary_context_switches_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_posix_involuntary_context_switches_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_file_pool_files_created_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_file_pool_files_created_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_file_pool_files_count_peak_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_file_pool_files_count_peak_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_file_pool_files_size_bytes_peak_bucket{job="buildbarn"}[1m])) by (service, le)',
          record: 'service_le:buildbarn_builder_build_executor_file_pool_files_size_bytes_peak_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_file_pool_operations_count_bucket{job="buildbarn"}[1m])) by (service, le, operation)',
          record: 'service_le_operation:buildbarn_builder_build_executor_file_pool_operations_count_bucket:irate1m',
        },
        {
          expr: 'sum(irate(buildbarn_builder_build_executor_file_pool_operations_size_bytes_bucket{job="buildbarn"}[1m])) by (service, le, operation)',
          record: 'service_le_operation:buildbarn_builder_build_executor_file_pool_operations_size_bytes_bucket:irate1m',
        },

        // Recording rules for the "Eviction sets" dashboard.
        {
          expr: 'sum(rate(buildbarn_eviction_set_operations_total{job="buildbarn"}[1h])) by (service, name, operation)',
          record: 'service_name_operation:buildbarn_eviction_set_operations:rate1h',
        },

        // Recording rules used by the 'gRPC clients' dashboard.
        {
          expr: |||
            sum(
              grpc_client_started_total{job="buildbarn"}
              -
              sum(grpc_client_handled_total{job="buildbarn"}) without (grpc_code)
            ) by (grpc_method, grpc_service, service)
          |||,
          record: 'grpc_method_grpc_service_service:grpc_client_in_flight:sum',
        },
        {
          expr: 'sum(irate(grpc_client_handled_total{job="buildbarn"}[1m])) by (grpc_code, grpc_method, grpc_service, service)',
          record: 'grpc_code_grpc_method_grpc_service_service:grpc_client_handled:irate1m',
        },
        {
          expr: 'sum(irate(grpc_client_msg_sent_total{job="buildbarn"}[1m])) by (grpc_method, grpc_service, service)',
          record: 'grpc_method_grpc_service_service:grpc_client_msg_sent:irate1m',
        },
        {
          expr: 'sum(irate(grpc_client_msg_received_total{job="buildbarn"}[1m])) by (grpc_method, grpc_service, service)',
          record: 'grpc_method_grpc_service_service:grpc_client_msg_received:irate1m',
        },
        {
          expr: 'sum(irate(grpc_client_handling_seconds_bucket{job="buildbarn"}[1m])) by (grpc_method, grpc_service, service, le)',
          record: 'grpc_method_grpc_service_service_le:grpc_client_handling_seconds_bucket:irate1m',
        },

        // Recording rules used by the 'gRPC servers' dashboard.
        {
          expr: |||
            sum(
              grpc_server_started_total{job="buildbarn"}
              -
              sum(grpc_server_handled_total{job="buildbarn"}) without (grpc_code)
            ) by (grpc_method, grpc_service, service)
          |||,
          record: 'grpc_method_grpc_service_service:grpc_server_in_flight:sum',
        },
        {
          expr: 'sum(irate(grpc_server_handled_total{job="buildbarn"}[1m])) by (grpc_method, grpc_service, service)',
          record: 'grpc_method_grpc_service_service:grpc_server_handled:irate1m',
        },
        {
          expr: 'sum(irate(grpc_server_handled_total{job="buildbarn"}[1m])) by (grpc_code, grpc_method, grpc_service, service)',
          record: 'grpc_code_grpc_method_grpc_service_service:grpc_server_handled:irate1m',
        },
        {
          expr: 'sum(irate(grpc_server_msg_sent_total{job="buildbarn"}[1m])) by (grpc_method, grpc_service, service)',
          record: 'grpc_method_grpc_service_service:grpc_server_msg_sent:irate1m',
        },
        {
          expr: 'sum(irate(grpc_server_msg_received_total{job="buildbarn"}[1m])) by (grpc_method, grpc_service, service)',
          record: 'grpc_method_grpc_service_service:grpc_server_msg_received:irate1m',
        },
        {
          expr: 'sum(irate(grpc_server_handling_seconds_bucket{job="buildbarn"}[1m])) by (grpc_method, grpc_service, service, le)',
          record: 'grpc_method_grpc_service_service_le:grpc_server_handling_seconds_bucket:irate1m',
        },
      ],
    },
  ],
}
