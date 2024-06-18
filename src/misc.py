from pathlib import Path
import oauth2client
from oauth2client.service_account import ServiceAccountCredentials
import gspread
from df2gspread import gspread2df as g2d
import pandas as pd


def gg_authentication(google_key_file: Path):
    scope = "https://spreadsheets.google.com/feeds"
    credentials = ServiceAccountCredentials.from_json_keyfile_name(
        google_key_file, scope
    )
    gc = gspread.authorize(credentials)
    authenticate = {"gc": gc, "credentials": credentials}
    return authenticate


def read_ggs(
    credentials: oauth2client.service_account.ServiceAccountCredentials,
    google_sheet_id: str,
    wks_name: str,
) -> pd.DataFrame:
    data = g2d.download(
        google_sheet_id,
        wks_name,
        col_names=True,
        row_names=False,
        credentials=credentials,
    )
    return data


def format_sql(sql_query_file: Path, params: dict = None) -> str:
    with open(sql_query_file, "r") as f:
        sql = f.read()
    if params is not None:
        sql = sql.format(**params)
    return sql
