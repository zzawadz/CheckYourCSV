source("code.R")

library(shiny)

dashboardPage(
  dashboardHeader(title = "CheckYourCSV"),
  dashboardSidebar(
    fileInput("dataFile",label = "Upload CSV"),
    sidebarMenu(
    menuItem("Problems info", tabName = "problemsTab"),
    menuItem("Rows with problems", tabName = "problemsRowsTab"),
    menuItem("Raw Data", tabName = "rawDataTab"),
    menuItem("Download clean data", tabName = "downloadTab"),
    menuItem("App Information", tabName = "appInfoTab"))
  ),
  dashboardBody(
    tabItems(
      tabItem("problemsTab", dataTableOutput("problems")),
      tabItem("problemsRowsTab", dataTableOutput("problemsRows")),
      tabItem("rawDataTab", dataTableOutput("rawData")),
      tabItem("downloadTab", downloadButton("cleanData", "Get your data without problematic rows")),
      tabItem("appInfoTab", 
              fluidRow(
                # Box with textOutput
                box(
                  title = "License:",
                  background = "green",
                  width = 4,
                  h2("GPL (>= 2)"),
                  h4("This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version."),
                  h4("
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details."),
    h4("
    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA")
                ),
                box(
                  title = "Safety:",
                  background = "blue",
                  width = 4,
                  h3(" I do not keep any data, but..."),
                  h4("... if you are using this app online it is NOT secure:( It uses unencrypted http connection. Be sure that you are not uploading any confidental data!")
                )))
    )
    
  )
)
#   fluidPage(
# 
#   # Application title
#   titlePanel(),
# 
#   # Sidebar with a slider input for number of bins
#   sidebarLayout(
#     sidebarPanel(
#       )
#     ),
# 
#     # Show a plot of the generated distribution
#     mainPanel(
#       tabsetPanel(
#         tabPanel("Problems",
#           
#         ),
#         ,
#         tabPanel("Information",
#                  )
#     ))
#     
#   )
# ))
