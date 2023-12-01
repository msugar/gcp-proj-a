# Troubleshooting

## Problems

* [Common issues](#common-issues)
* [Seed Project missing APIs](#seed-project-missing-apis) - The Seed Project is missing required APIs.

- - -
### Common issues

* [Unable to query status of default GCE service
  account](#unable-to-query-status-of-default-gce-service-account)

#### Unable to query status of default GCE service account

When the Project Factory is used with a misconfigured Seed Project, it will
partially generate a new Target Project, fail, and enter a state where it can no
longer generate Target Projects.

**Error message:**

```
Error: Error enabling the Compute Engine API required to delete the default network: failed to enable services: failed on request preconditions: googleapi: Error 400: Billing account for project '[project number]' is not found. Billing must be enabled for activation of service(s) 'compute.googleapis.com,compute.googleapis.com,compute.googleapis.com' to proceed.
```
**Cause:**

The Project Factory has generated a new Target Project but could not enable the
`compute.googleapis.com` API. This causes Terraform to get jammed, with the
following causal chain:

1.  `terraform plan` tries to query the default GCE service account.
1.  The query fails because the `compute.googleapis.com` API is not enabled on
    the Target Project.
1.  The `compute.googleapis.com` API is not enabled on the Target Project
    because it does not have an associated billing account.
1.  The Target Project does not have an associated billing account for one of
    the following causes:
    *   The Seed Project does not have the `cloudbilling.googleapis.com` API
        enabled, so Terraform cannot enable billing on the Target Project.
    *   The Seed Service Account does not have the `roles/billing.user` role on
        the associated billing account, and cannot link the Target Project with
        the billing account.

This issue is confusing because the error indicates that the
`compute.googleapis.com` API is disabled on the Target Project, but the absence
of the Google Compute Engine API is a symptom of an issue with configuring
billing, rather than the cause of the issue itself.

**Solution:**

In order to recover the Terraform configuration, the required APIs need to be enabled on the Seed Project and Target Project.

1.  Enable billing on the Seed Project:
    1.  Enable the `cloudbilling.googleapis.com` API on the Seed Project:
        ```sh
        # Requires `roles/serviceusage.admin` on $SEED_PROJECT
        gcloud services enable cloudbilling.googleapis.com \
          --project "$SEED_PROJECT"
        ```
    1.  Associate a billing account with the Seed Project:
        ```sh
        # Requires `roles/billing.projectManager` on $SEED_PROJECT and
        # `roles/billing.user` on the billing account
        gcloud alpha billing projects link "$SEED_PROJECT" \
          --billing-account=$BILLING_ACCOUNT
        ```

1.  Enable `compute.googleapis.com` on the Target Project:
    ```sh
    # Requires `roles/serviceusage.admin` on $TARGET_PROJECT
    gcloud services enable compute.googleapis.com --project $TARGET_PROJECT
    ```
    This should be run in the context of the Seed Service Account.  You can add
    the Seed Service Account to your list of authentication credentials by
    issuing the following command and importing the Seed Service Account key:
    ```sh
    gcloud auth activate-service-account \
      --key-file=path-to-service-account-credentials.json
    ```

Source:
https://github.com/terraform-google-modules/terraform-google-project-factory/blob/master/docs/TROUBLESHOOTING.md