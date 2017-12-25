#!/usr/bin/php
<?php

error_reporting(E_ERROR);

if ($argc < 2)
{
  echo "\n";
  echo "usage:\n php YnabCsvConverter.php ~/<directory>/transactions.txt\n";
  echo "\n";
  exit();
}

$converter = new YnabCsvConverter();
$converter->convert($argv[1]);

class YnabCsvConverter extends stdClass
{
	private $_data;
	
	private $_accounts;	
	
	/** Please update the following export directory path to your local preference
	 *  Unfortunately the ~ isn't supported in PHP without a lot of rework
	 */
	private $_exportDirectory = './';
	
	public function convert($filename)
	{
		/**
		 * Convert for each account found in CSV export
		 */
		try
		{
			$file_handle   = $this->_readImportFile($filename);
			$this->_convertCsv($file_handle);
			fclose($file_handle);
			
			$this->_exportAccounts();
			echo "Exported accounts to '{$this->_exportDirectory}'\n";
		}
		catch (Exception $e)
		{
			print("Failed, with message:\n");
			print("- " . $e->getMessage() . "\n");
			return false;
		}
		return true;
	}
	
	private function _readImportFile($filename)
	{
		$handle = fopen($filename, "r");
		if (!$handle)
		{
			throw new Exception("CSV file '{$filename}' could not be read");
		}
		return $handle;
	}
	
	private function _getFileHeaders()
	{
		return array(
		  'Date',
		  'Payee',
		  'Category',
		  'Memo',
		  'Outflow',
		  'Inflow'
		  );
	}	
	
	private function _convertCsv($file_handle)
	{
		$this->_accounts = array();
		while ($line = fgetcsv($file_handle))
		{
			$account_nr = $this->_getAccountNr($line);
			$ynab_object = $this->_convertLine($line);
			$this->_accounts[$account_nr][] = $ynab_object;
		}
	}
	
	private function _convertLine(array $csv_line)
	{
		$ynab_line = new stdClass();
		
		$ynab_line->date     = $this->_getDate($csv_line);
		$ynab_line->payee    = trim($this->_getPayee($csv_line));
		$ynab_line->category = '';
		$ynab_line->memo 	 = trim($this->_getDescription($csv_line));
		$ynab_line->outflow  = '';
		$ynab_line->inflow   = '';
		
		switch ($csv_line[3])
		{
			case 'D':
				$ynab_line->outflow = $csv_line[4];
				break;
			case 'C':
				$ynab_line->inflow = $csv_line[4];
				break;
		}
		
		return $ynab_line;
	}
	
	private function _exportFile($filename, array $transactions)
	{
		$file_handle = fopen($this->_exportDirectory . $filename . '.csv', 'w+');
		fputcsv($file_handle, $this->_getFileHeaders());
		
		foreach ($transactions as $ynab_object)
		{
			$transaction = array(
				$ynab_object->date,
				$ynab_object->payee,
				$ynab_object->category,
				$ynab_object->memo,
				$ynab_object->outflow,
				$ynab_object->inflow
				);
			fputcsv($file_handle, $transaction);
		}
		fclose($file_handle);
	}
	
	private function _exportAccounts()
	{
		foreach ($this->_accounts as $account_nr => $transactions)
		{
			echo 'Exporting account "' . $account_nr . '" with ' . count($transactions) . ' transactions' . "\n";
			$this->_exportFile($account_nr, $transactions);
		}
	}
	
	private function _convertDate($date)
	{
		$year  = substr($date, 0, 4);
		$month = substr($date, 4, 2);
		$day   = substr($date, 6, 2);
		
		return $day . '/' . $month . '/' . $year;
	}
	
	private function _getAccountNr(array $csv_line)
	{
		return $csv_line[0];
	}
	
	private function _getDate(array $csv_line)
	{
		return $this->_convertDate($csv_line[2]);
	}
	
	private function _getPayee(array $csv_line)
	{
		switch ($csv_line[8])
		{
			case "ba": // betaalautomaat
			case "ga": // geldautomaat
				return $csv_line[9] . " - " . $csv_line[10];
				break;
			case "tb": // spaaropdracht?
			case "ei": // europese incasso
			case "cb": // crediteuren betaling (geld ontvangen)
			case "bg": // betaling
			case "db": // betaling aan bank
				return $csv_line[5] . " - " . $csv_line[6];
				break;
			default:
				return $csv_line[5] . " - " . $csv_line[10];
		}
	}
	
	private function _getDescription(array $parsed_csv_line)
	{
		return $parsed_csv_line[10] . " "
		     . $parsed_csv_line[11] . " "
		     . $parsed_csv_line[12] . " "
		     . $parsed_csv_line[13] . " "
		     . $parsed_csv_line[14] . " "
		     . $parsed_csv_line[15];
	}
}
