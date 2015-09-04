#!/usr/bin/env python
import csv
import sys
import json
import uuid
import gzip
import os

class ExtractData:

    def __init__(self):
	pass

    def handle_arguments(self):
        """
        Process the command line arguments
        """
        pass

    def initialize(self):
        """
        Perform any initial configuration
        """
        self.data_directory = os.path.join(os.getcwdu(), 'data_store')
        if not os.path.exists(self.data_directory):
            os.mkdir(self.data_directory)

    def execute(self):
        self.handle_arguments()
        self.initialize()
        self.load(sys.argv[1])

    def load(self, file_name):
        """
        Load the zip file with our DVD and process 
        """
        with gzip.open(file_name, 'rb') as f:
            reader = csv.DictReader(f)
            for row in reader:
                self.process_row(row)

    def process_row(self, row):
        """
        Handle the processing of the individual row of data
        """
        try:
            self.write_row(json.dumps(row))
        except UnicodeDecodeError: 
	    pass

    def write_row(self, row):
        unique_file_name = uuid.uuid4()
        path = os.path.join(self.data_directory, str(unique_file_name))
        #print(path)
        self.write_data(path, row)
        pass

    def write_data(self, path, data):
        """
        Writes data to provide file name
        """
        with open(path, 'wt') as f:
            f.write(data)
        

if __name__ == "__main__":
    ed = ExtractData()
    ed.execute()
    
