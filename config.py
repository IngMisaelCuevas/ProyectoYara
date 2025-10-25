import os

class Config:
    TOKEN = os.getenv("WHATSAPP_TOKEN", "EAAV92nGpCFEBPq060LJ1tbFfJwiw23L6pf23JG0qPQsv6L9H9ygOrRo5xsORyLs3Ad7Wmfavcxap39uaqKkydrDRzP48ZCxZBezXD9gVU8T4FPpNp5K7cL7LcfqfqnWYOyaAFluPptIlBREkgYTZB6ZCdDFeTMgmCihPHkt4wXakwi1i9eLF1lvTsokH4AwxcQZDZD")
    
    PHONE_NUMBER_ID = os.getenv("WHATSAPP_PHONE_ID", "821418581049671")

    DB_HOST = os.getenv("DB_HOST", "localhost")
    DB_USER = os.getenv("DB_USER", "root")
    DB_PASSWORD = os.getenv("DB_PASSWORD", "yara1234")
    DB_NAME = os.getenv("DB_NAME", "cjr_bot")
    #DB_NAME = os.getenv("DB_PUERTO", "3307")
