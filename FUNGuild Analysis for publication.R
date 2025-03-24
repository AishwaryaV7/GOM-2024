require(ggplot2)
require(tidyr)
require(readxl)
require(dplyr)
require(ggpubr)

###### By Tree ####
#set file_path to spreadsheet containing tally of primary guild occurrences
file_path <- "...Trees and Wood Tally for R Boxplots.xlsx"

data <- read_excel(file_path)

# Rename columns if necessary
colnames(data) <- c("Category", "Tree", "Guild", "Primary_Guild_Occurrences")
# Perform t-test or Wilcoxon test for each guild
test_results <- data %>%
  group_by(Guild) %>%
  summarise(
    p_value = wilcox.test(Primary_Guild_Occurrences ~ Category)$p.value,
    significance = case_when(
      p_value < 0.001 ~ "***",
      p_value < 0.01 ~ "**",
      p_value < 0.05 ~ "*",
      TRUE ~ "ns"
    )
  )
# Print test results
print(test_results)
# Create the boxplot
plot <- ggplot(data, aes(x = Guild, y = Primary_Guild_Occurrences, fill = Category)) +
  geom_boxplot(outlier.size = 0.2, linewidth = 0.2) +
  theme_minimal() +
  scale_fill_manual(values = c("Trees w/ GOM" = "goldenrod1", "Trees w/o GOM" = "dodgerblue")) +
  labs(title = "",
       x = "Guild",
       y = "Primary Guild Occurrences",
       fill = "Category") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  stat_compare_means(aes(group = Category), method = "wilcox.test", label = "p.signif", hide.ns = TRUE)

print(plot)





##### By Wood ######

file_path <- ".../Trees and Wood Tally for R Boxplots.xlsx"

# Read the data
data <- read_excel(file_path, sheet = "Sheet2")
colnames(data) <- c("Category", "Guild", "Occurrences")

# Perform Wilcoxon test for each guild and assign significance levels
test_results <- data2 %>%
  group_by(Guild) %>%
  summarise(
    p_value = wilcox.test(Primary_Guild_Occurrences ~ Category)$p.value,
    significance = case_when(
      p_value < 0.001 ~ "***",
      p_value < 0.01 ~ "**",
      p_value < 0.05 ~ "*",
      TRUE ~ "ns"
    )
  )
# Print test results
print(test_results)

# Create the boxplot
plot <- ggplot(data, aes(x = Guild, y = Occurrences, fill = Category)) +
  geom_boxplot(outlier.size = 0.2, linewidth = 0.2) +
  theme_minimal() +
  scale_fill_manual(values = c("Wood w/ GOM" = "goldenrod1", "Wood w/o GOM" = "dodgerblue")) +
  labs(title = "",
       x = "Guild",
       y = "Primary Guild Occurrences",
       fill = "Category") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  stat_compare_means(aes(group = Category), method = "wilcox.test", label = "p.signif", hide.ns = TRUE)

# Print the final plot
print(plot)
