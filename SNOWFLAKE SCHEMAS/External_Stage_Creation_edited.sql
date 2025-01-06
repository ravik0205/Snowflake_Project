
CREATE OR REPLACE STORAGE INTEGRATION azure_pacificretail_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = AZURE
  ENABLED = TRUE
  AZURE_TENANT_ID = 'Tenant_ID'
  STORAGE_ALLOWED_LOCATIONS = ('azure://pacificretailstg.blob.core.windows.net/<container_name>/');


