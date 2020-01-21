#import pypdf2

from PyPDF2 import PdfFileReader
def get_info(path):
    with open(path, 'rb') as f:
        pdf = PdfFileReader(f)
        info = pdf.getDocumentInfo()
        number_of_pages = pdf.getNumPages()
        print(info)
        print(pdf)
        print(number_of_pages)
        for i in range(0,number_of_pages):
            objPdf = pdf.getPage(i)
            print('printing page ',i)
            print(objPdf.extractText())

get_info('test2.pdf')
