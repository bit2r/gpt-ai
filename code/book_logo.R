################################################################################
##
##                        챗GPT AI 로고
##                      이광춘, 2024-05-26
##
################################################################################

# 1. AI 배경 이미지 ------------------------------------------------------------

library(tidyverse)
library(openai)
library(cropcircles)
library(magick)
library(showtext)
library(ggpath)
library(ggtext)
library(glue)
library(sysfonts)
library(showtext)

showtext::showtext_auto()

extrafont::loadfonts()

# Sys.setenv(OPENAI_API_KEY = Sys.getenv("OPENAI_API_KEY"))

# x <- create_image("a amazing newspaper as the sun is rising behind many news full of fake and misinformation")
# x <- create_image("multicolor sparkly glitter bursting from the tip of an tomato as it touches the paper, bright, realism")
# x <- create_image("draw Korean ink painting style landscape image, orange tone, minimalism.")
# from https://jehyunlee.github.io/2023/12/25/General-33-ChatGPT_DataAnalysis/

## 원본이미지 다운로드
# download.file(url = x$data$url, destfile = "images/raw_image.png", mode = "wb")


# 2. 로고 ------------------------------------------------------------
## 2.1. 소스 이미지
stat_bg <- magick::image_read("assets/logo_raw.png")

# stat_bg <- stat_bg %>%
# image_resize(geometry = c(300, 300))
# image_resize('25%x25%')



# 3. 텍스트 ------------------------------------------------------------

font_add_google('inconsolata', 'Inconsolata')
font_add_google('Dokdo', 'dokdo')
# 글꼴 다운로드 : https://fontawesome.com/download
font_add('fa-brands', 'data-raw/fonts/Font Awesome 6 Brands-Regular-400.otf')
showtext_auto()
ft <- "dokdo"
ft_github <- "inconsolata"
txt <- "#00FF00" # 폰트 색상

pkg_name <- "챗GPT 인공지능"

img_cropped <- hex_crop(
  images = stat_bg,
  border_colour = "#403b39",
  border_size = 5
)

stat_gg <- ggplot() +
  geom_from_path(aes(0.5, 0.5, path = img_cropped)) +
  annotate("text", x = 0.43, y = 0.10, label = pkg_name,
           family = ft, size = 27, colour = txt,
           angle = 30, hjust = 0, fontface = "bold") +
  # add github
  annotate("richtext", x=0.50, y = 0.04, family = ft_github,
           size = 11, angle = 30,
           colour = txt, hjust = 0,
           label = glue("<span style='font-family:fa-brands; color:{txt}'>&#xf09b;&nbsp;</span> bit2r/gpt-ai"),
           label.color = NA, fill = NA)   +
  xlim(0, 1) +
  ylim(0, 1) +
  theme_void() +
  coord_fixed()

# 4. 배경 투명 ------------------------------------------------------------
# ggsave("images/logo_gg.png", plot = stat_gg, bg = "transparent")
#
# # Read the image back in with magick
# stat_raw_gg <- image_read("images/logo_gg.png")
#
# # Apply image_transparent
# stat_transparent_gg <- image_transparent(stat_raw_gg, 'white')

# 5. 이미지 저장 ------------------------------------------------------------
ragg::agg_png("assets/logo.png",
              width = 4.39, height = 5.08, units = "cm", res = 600)
stat_gg
dev.off()

