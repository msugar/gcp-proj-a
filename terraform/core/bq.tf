resource "google_bigquery_dataset" "alpha" {
  dataset_id = "alpha"
}

resource "google_bigquery_table" "alpha_1" {
  dataset_id = google_bigquery_dataset.alpha.dataset_id
  table_id   = "alpha_1"

  schema = <<EOF
 [
   {
     "name": "ts",
     "type": "TIMESTAMP"
   },
   {
     "name": "foo",
     "type": "INT64"
   },
   {
     "name": "bar",
     "type": "STRING"
   }
 ]
 EOF

  time_partitioning {
    type  = "DAY"
    field = "ts"
  }
}

resource "google_bigquery_table" "alpha_2" {
  dataset_id = google_bigquery_dataset.alpha.dataset_id
  table_id   = "alpha_2"

  schema = <<EOF
 [
   {
     "name": "ts",
     "type": "TIMESTAMP"
   },
   {
     "name": "foo",
     "type": "INT64"
   },
   {
     "name": "bar",
     "type": "STRING"
   }
 ]
 EOF

  time_partitioning {
    type  = "DAY"
    field = "ts"
  }

  clustering = ["ts", "foo"]
}

resource "google_bigquery_dataset" "beta" {
  dataset_id = "beta"
}

resource "google_bigquery_table" "beta_1" {
  dataset_id = google_bigquery_dataset.beta.dataset_id
  table_id   = "beta_1"

  schema = <<EOF
 [
   {
     "name": "ts",
     "type": "TIMESTAMP"
   },
   {
     "name": "foo",
     "type": "INT64"
   },
   {
     "name": "bar",
     "type": "STRING"
   }
 ]
 EOF

  time_partitioning {
    type  = "DAY"
    field = "ts"
  }

  clustering = ["ts", "foo", "bar"]
}
