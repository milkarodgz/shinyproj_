#ui.R

shinyUI(dashboardPage(
  dashboardHeader(title = "NYC Collisions"),
  dashboardSidebar(
    sidebarUserPanel("Menu"),
    sidebarMenu(
      menuItem("Home"),
      menuItem("Map", tabName = "Map", icon = icon("map-marker-alt")),
      menuItem("Accidents",tabName = "accidents",icon = icon("car-crash")),
      menuItem("Data", tabName = "data", icon = icon("road")),
      menuItem("github", tabName = "Github", icon("file-code-o"), href = "https://github.com/milkarodgz")
      )),
  dashboardBody(
    tags$head(tags$style(
      HTML(
        '
        /* logo */
        .skin-blue .main-header .logo {
        background-color: rgb(255,255,255); color:        rgb(0,144,197);
        font-weight: bold;font-size: 24px;text-align: Right;
        }
        
        /* logo when hovered */
        .skin-blue .main-header .logo:hover {
        background-color: rgb(255,255,255);
        }
        
        /* navbar (rest of the header) */
        .skin-blue .main-header .navbar {
        background-color: rgb(255,255,255);
        }
        
        /* main sidebar */
        .skin-blue .main-sidebar {
        background-color: rgb(7, 7, 7);;
        }
        
        /* active selected tab in the sidebarmenu */
        .skin-blue .main-sidebar .sidebar .sidebar-menu .active a{
        background-color: #696969);
        color: rgb(86, 136, 183);font-weight: bold;font-size: 18px;
        }
        
        /* other links in the sidebarmenu */
        .skin-blue .main-sidebar .sidebar .sidebar-menu a{
        background-color: rgb(44, 48, 48);
        color: rgb(255,255,255);font-weight: bold;
        }
        
        /* other links in the sidebarmenu when hovered */
        .skin-blue .main-sidebar .sidebar .sidebar-menu a:hover{
        background-color: rgb(232,245,251);color: rgb(0,144,197);font-weight: bold;
        }
        
        /* toggle button color  */
        .skin-blue .main-header .navbar .sidebar-toggle{
        background-color: rgb(255,255,255);color:rgb(0,144,197);
        }
        
        /* toggle button when hovered  */
        .skin-blue .main-header .navbar .sidebar-toggle:hover{
        background-color: rgb(0,144,197);color:rgb(0,0,0);
        }
        '
      )
      )),
    tabItems(
      tabItem(tabName = "Map",
        fluidRow(
          selectInput("borough", "Choose a borough:", choices = unique(df1$BOROUGH)),
          textOutput("result")
        ),
        fluidRow(
          infoBoxOutput(outputId = "maxBox"),
          infoBoxOutput(outputId = "minBox")
        ),
        
      
        fluidRow(leafletOutput(outputId = "mymap", height = 1000)
        )),
      
      tabItem(tabName = "accidents",
              # fluidRow(selectInput("borough1", "Choose a borough:", choices=unique(df1$BOROUGH))
              # ),
        # fluidRow(
        #   infoBoxOutput(outputId = "maxBox"),
        #   infoBoxOutput(outputId = "minBox")#,
        fluidRow(leafletOutput(outputId ="zmap", height = 1000))
           
         ),
        
      
      tabItem(tabName = "data",
              fluidPage(h1("NYC Collisions 2015-2018", align="center"),
                        br(),
              fluidRow(column(width = 4, selectizeInput('ZIP.CODE', label = "zip code", choices=unique(df1$ZIP.CODE)),
                        column(width=4, uiOutput("dynamic_widget"))),
                       br(),
                       fluidRow(column(width=4, uiOutput("TOTAL.INJURED")),
                                column(width=4, uiOutput("TOTAL.FATALITIES"))),
                       fluidRow(box(DT::dataTableOutput(outputId = "table"), width=12))
                       
              )))
                              
              
              )))
    )
    #   )
    # ))


######################
# tabItem(tabName = "data_by_borough",
#         fluidRow(box(plotOutput("borough_plot"), width = 8),
#                  box(
#                    checkboxGroupInput("borough", label = h3("Borough"),
#                                       choices = list("MANHATTAN" = "MANHATTAN",
#                                                      "BROOKLYN" = "BROOKLYN",
#                                                      "QUEENS" = "QUEENS",
#                                                      "BRONX" = "BRONX",
#                                                      "STATEN ISLAND" = "STATEN ISLAND"),
#                                       selected = c("MANHATTAN", "STATEN ISLAND")),
#                    width = 4))),

# library(DT)
# library(shiny)
# library(shinydashboard)
# 
# shinyUI(dashboardPage(
#   dashboardHeader(title = "My Dashboard"),
#   dashboardSidebar(
#     
#     sidebarUserPanel("NYC DSA",
#                      image = "https://yt3.ggpht.com/-04uuTMHfDz4/AAAAAAAAAAI/AAAAAAAAAAA/Kjeupp-eNNg/s100-c-k-no-rj-c0xffffff/photo.jpg"),
#     sidebarMenu(
#       menuItem("Map", tabName = "map", icon = icon("map")),
#       menuItem("Data", tabName = "data", icon = icon("database"))
#     ),
#     selectizeInput("selected",
#                    "Select Item to Display",
#                    choice)
#   ),
#   dashboardBody(
#     tags$head(
#       tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
#     ),
#     tabItems(
#       tabItem(tabName = "map",
#               fluidRow(infoBoxOutput("maxBox"),
#                        infoBoxOutput("minBox"),
#                        infoBoxOutput("avgBox")),
#               fluidRow(box(htmlOutput("map"), height = 300),
#                        box(htmlOutput("hist"), height = 300))),
#       tabItem(tabName = "data",
#               fluidRow(box(DT::dataTableOutput("table"), width = 12)))
#     )
#   )
# ))
# ##################
