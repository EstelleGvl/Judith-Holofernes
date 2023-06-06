library(readr)
library(dplyr)
library(ggplot2)
library(stringi)
library(jpeg)
library(igraph)

# fsa <- read_csv(file.path("data", "fsa-color.csv"))
#
# fsa$avg_saturation <- 0
# fsa$avg_value <- 0
# fsa$avg_red    <- 0
# fsa$avg_orange <- 0
# fsa$avg_yellow <- 0
# fsa$avg_green  <- 0
# fsa$avg_blue   <- 0
# fsa$avg_violet <- 0
# fsa$avg_black  <- 0
# fsa$avg_grey   <- 0
# fsa$avg_white  <- 0
#
# for (i in seq_len(nrow(fsa)))
# {
#   img <- readJPEG(file.path("images", "fsa-color", fsa$path[i]))
#   hsv <- rgb2hsv(as.numeric(img[,,1]), as.numeric(img[,,2]), as.numeric(img[,,3]), maxColorValue = 1)
#   index <- which((hsv[2,] > 0.3) & (hsv[3,] > 0.3))
#   if (length(index))
#   {
#     fsa$avg_red[i]    <- sum(hsv[1,index] < 0.075 | hsv[1,index] > 0.861) / prod(dim(img))
#     fsa$avg_orange[i] <- sum(between(hsv[1,index], 0.075, 0.122)) / prod(dim(img))
#     fsa$avg_yellow[i] <- sum(between(hsv[1,index], 0.122, 0.194)) / prod(dim(img))
#     fsa$avg_green[i]  <- sum(between(hsv[1,index], 0.194, 0.464)) / prod(dim(img))
#     fsa$avg_blue[i]   <- sum(between(hsv[1,index], 0.464, 0.708)) / prod(dim(img))
#     fsa$avg_violet[i] <- sum(between(hsv[1,index], 0.708, 0.861)) / prod(dim(img))
#   }
#
#   index <- which((hsv[2,] <= 0.3) | (hsv[3,] <= 0.3))
#   if (length(index))
#   {
#     fsa$avg_black[i]  <- sum(hsv[3,] < 0.25) / prod(dim(img))
#     fsa$avg_grey[i]   <- sum(between(hsv[3,], 0.25, 0.8)) / prod(dim(img))
#     fsa$avg_white[i]  <- sum(hsv[3,] > 0.8)  / prod(dim(img))
#   }
#
#   fsa$avg_saturation[i] <- mean(hsv[2,hsv[3,] > 0.3])
#   fsa$avg_value[i] <- mean(img)
#
#   if ((i %% 10) == 0) print(sprintf("Done with %d of %d", i, nrow(fsa)))
# }
#
# write_csv(fsa, file.path("data", "fsa-color.csv"))
#


fsa <- read_csv(file.path("data", "wikiart.csv"))

fsa$avg_saturation <- 0
fsa$avg_value <- 0
fsa$avg_red    <- 0
fsa$avg_orange <- 0
fsa$avg_yellow <- 0
fsa$avg_green  <- 0
fsa$avg_blue   <- 0
fsa$avg_violet <- 0
fsa$avg_black  <- 0
fsa$avg_grey   <- 0
fsa$avg_white  <- 0

for (i in seq_len(nrow(fsa)))
{
  img <- readJPEG(file.path("images", "wikiart", fsa$path[i]))
  hsv <- rgb2hsv(as.numeric(img[,,1]), as.numeric(img[,,2]), as.numeric(img[,,3]), maxColorValue = 1)
  index <- which((hsv[2,] > 0.3) & (hsv[3,] > 0.3))
  if (length(index))
  {
    fsa$avg_red[i]    <- sum(hsv[1,index] < 0.075 | hsv[1,index] > 0.861) / prod(dim(img))
    fsa$avg_orange[i] <- sum(between(hsv[1,index], 0.075, 0.122)) / prod(dim(img))
    fsa$avg_yellow[i] <- sum(between(hsv[1,index], 0.122, 0.194)) / prod(dim(img))
    fsa$avg_green[i]  <- sum(between(hsv[1,index], 0.194, 0.464)) / prod(dim(img))
    fsa$avg_blue[i]   <- sum(between(hsv[1,index], 0.464, 0.708)) / prod(dim(img))
    fsa$avg_violet[i] <- sum(between(hsv[1,index], 0.708, 0.861)) / prod(dim(img))
  }

  index <- which((hsv[2,] <= 0.3) | (hsv[3,] <= 0.3))
  if (length(index))
  {
    fsa$avg_black[i]  <- sum(hsv[3,] < 0.25) / prod(dim(img))
    fsa$avg_grey[i]   <- sum(between(hsv[3,], 0.25, 0.8)) / prod(dim(img))
    fsa$avg_white[i]  <- sum(hsv[3,] > 0.8)  / prod(dim(img))
  }

  fsa$avg_saturation[i] <- mean(hsv[2,hsv[3,] > 0.3])
  fsa$avg_value[i] <- mean(img)

  if ((i %% 10) == 0) print(sprintf("Done with %d of %d", i, nrow(fsa)))
}

write_csv(fsa, file.path("data", "wikiart.csv"))


# fsa <- read_csv(file.path("data", "fsa-bw.csv"))
#
# fsa$avg_saturation <- 0
# fsa$avg_value <- 0
#
# for (i in seq_len(nrow(fsa)))
# {
#   img <- readJPEG(file.path("images", "fsa-bw", fsa$path[i]))
#   hsv <- rgb2hsv(as.numeric(img[,,1]), as.numeric(img[,,2]), as.numeric(img[,,3]), maxColorValue = 1)
#   fsa$avg_saturation[i] <- mean(hsv[2,hsv[3,] > 0.3])
#   fsa$avg_value[i] <- mean(img)
#
#   if ((i %% 10) == 0) print(sprintf("Done with %d of %d", i, nrow(fsa)))
# }
#
# write_csv(fsa, file.path("data", "fsa-bw.csv"))
