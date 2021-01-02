library(shiny)
library(DBI)
library(odbc)
library(DT)
#library(RODBC)



#con<- odbcDriverConnect(connection = "Driver=FreeTDS;TDS_Version=8.0;Server=cmserv.database.windows.net;Port=1433;Database=cm;Uid=utkuco;Pwd=Utku-coskun1;Encrypt=no;TrustServerCertificate=no;Connection Timeout=30;")
#Driver={ODBC Driver 13 for SQL Server};Server=tcp:cmserv.database.windows.net,1433;Database=cm;Uid=utkuco;Pwd={your_password_here};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;

con <- DBI::dbConnect(odbc::odbc(),
                Driver = "ODBC Driver 17 for SQL Server",
                 Server = "tcp:cmserv.database.windows.net",
                 Database = "cm",
                 UID = "utkuco",
                 #PWD = rstudioapi::askForPassword("Database password"),
                 PWD = "Utku-coskun1",
                 Port = 1433)

#con<- odbcDriverConnect(connection ="Driver=FreeTDS;TDS_Version=7.2;Server=cmserv.database.windows.net;Port=1433;Database=cm;Uid=utkuco;Pwd=Utku-coskun1;Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;")
#moov<-RODBC::sqlQuery(con, "SELECT * FROM datatbl")
moov<-  dbGetQuery(con, "SELECT * FROM datatbl")

ui <- fluidPage(
  
    titlePanel("Connect Test"),
        mainPanel(
          DT::dataTableOutput("testdata")
        )
    )

server <- function(input, output) {
  
  output$testdata = DT::renderDataTable({
     moov<- moov[1:10]
     moov
  })
}

shinyApp(ui = ui, server = server)
