require(devtools)
install_github("slidify", "slidify")
install_github("slidifyLibraries", "ramnathv")

library(slidify)
author("nk_jhu_dp_kobe")
slidify("index.Rmd")

publish(user = "nickkz", repo = "nk_jhu_dp")