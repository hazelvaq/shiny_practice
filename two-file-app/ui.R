ui <- navbarPage(
  
  title = "LTER Animal Data Explorer",
  
  # (Page 1) intro tabPanel ----
  tabPanel(title = "About this App",
           
           fluidRow(
             
             column(1),
             column(10, includeMarkdown("text/about.md")),
             column(1)
             
           ), #END intro text fluidRow ----
           
           hr(),
           includeMarkdown("text/footer.md")
           
  ), # END (Page 1) intro tabPanel
  
  # (Page 2) data viz tabPanel ----
  tabPanel(title = "Explore the Data",
           
           # tabsetPanel to contain tabs for data viz ----
           tabsetPanel(
             
             # trout tabPanel ----
             tabPanel(title = "Trout",
                      
                      # trout sidebarLayout ----
                      sidebarLayout(
                        
                        # trout sidebarPanel ----
                        sidebarPanel(
                          
                          # channel type pickerinput
                          pickerInput(inputId = "channel_type_input",
                                      label = "Select channel type(s):",
                                      choices = unique(clean_trout$channel_type),
                                      selected = c("cascade","pool"),
                                      # add boxes if you want to select all 
                                      options = pickerOptions(actionsBox = TRUE),
                                      # pick multiple
                                      multiple = TRUE),
                          
                          # section checkboxGroupButtons ----
                          checkboxGroupButtons(inputId = "section_input",
                                               label = "Select a sampling section(s):",
                                               choices = c("clear cut forest","old growth forest"),
                                               individual = FALSE, 
                                               # width of the sidebar panel
                                               justified = TRUE,
                                               size = "sm",
                                               # what icon for on or off 
                                               checkIcon = list(yes = icon("check"),
                                                                no = icon("xmark")))
                          
                        ), # END trout sidebarPanel
                        
                        # trout mainPanel ----
                        mainPanel(
                          
                          plotOutput(outputId = "trout_scatterplot_output") %>% 
                            withSpinner(color = "forestgreen", type = 1)
                          
                        ) # END trout mainPanel
                        
                      ) # END trout sidebarLayout
                      
             ), # END trout tabPanel 
             
             # penguin tabPanel ----
             tabPanel(title = "Penguins",
                      
                      # penguins sidebarLayout ----
                      sidebarLayout(
                        
                        # penguins sidebarPanel ----
                        sidebarPanel(
                          
                          # island type pickerinput
                          pickerInput(inputId = "penguins_island_input",
                                      label = "Select an island:",
                                      choices = unique(penguins$island),
                                      selected = unique(penguins$island),
                                      # add boxes if you want to select all 
                                      options = pickerOptions(actionsBox = TRUE),
                                      # pick multiple
                                      multiple = TRUE),
                          # bin sliderinput
                          sliderInput(inputId = "bin_num_input",
                                      label = "Select number of bins:",
                                      value = 25, min = 1, max = 100)
                          
                        ), # END penguin sidebarPanel
                        
                        # penguin mainPanel ----
                        mainPanel(
                          
                          # histogram output ----
                          plotOutput(outputId = "penguins_histogram_output") %>% 
                            withSpinner(color = "forestgreen", type = 4)
                          
                        ) # END penguin mainPanel
                      
             ) # END penguin tabPanel
             
           ) # END tabsetPanel
           
  ) # END (Page 2) data viz tabPanel
  
)) # END navbarPage
