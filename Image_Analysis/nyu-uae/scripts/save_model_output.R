library(readr)
library(keras)
library(dplyr)

Sys.setenv(KMP_DUPLICATE_LIB_OK="TRUE")

# load pre-trained ResNet-50 model
resnet50 <- application_resnet50(weights = 'imagenet', include_top = TRUE)
model_avg_pool <- keras_model(inputs = resnet50$input,
                              outputs = get_layer(resnet50, 'avg_pool')$output)


for (cn in c("movie-posters-1000"))
{
  # load the images
  data <- read_csv(file.path("data", sprintf("%s.csv", cn)), )
  Z <- array(0, dim = c(length(data$path), 224, 224, 3))
  for (i in seq_len(nrow(data)))
  {
    pt <- file.path("images", "movie-posters", data$path[i])
    image <- image_to_array(image_load(pt, target_size = c(224,224)))
    Z[i,,,] <- array_reshape(image, c(1, dim(image)))
  }
  Z <- imagenet_preprocess_input(Z)

  # embed into the avg_pool layer and save results
  X <- predict(model_avg_pool, x = Z, verbose = TRUE)
  write_rds(X, file.path("models", sprintf("%s-pool.rds", cn)))

  # embed into the final layer
  X <- predict(resnet50, x = Z, verbose = TRUE)
  preds <- Reduce(bind_rows, keras::imagenet_decode_predictions(X, top = 25))
  preds$path <- rep(data$path, each = 25)
  preds$rank <- rep(seq_len(25), nrow(data))
  write_csv(preds, file.path("models", sprintf("%s-resnet50.csv", cn)))
}
