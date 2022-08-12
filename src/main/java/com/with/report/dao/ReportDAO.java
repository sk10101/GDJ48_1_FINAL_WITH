package com.with.report.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.report.dto.ReportDTO;

public interface ReportDAO {

	ArrayList<ReportDTO> reportlist();

	void reportsend(HashMap<String, String> params);

}
