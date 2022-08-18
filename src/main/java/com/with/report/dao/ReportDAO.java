package com.with.report.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.report.dto.ReportDTO;

public interface ReportDAO {

	ArrayList<ReportDTO> reportList(HashMap<String, Object> map);

	void reportsend(HashMap<String, String> params);

	ReportDTO reportdetail(String report_idx);

	boolean reportcom(HashMap<String, String> params);

	void penaltycom(HashMap<String, String> params);

	int reportchk(HashMap<String, String> params);

	ArrayList<ReportDTO> allCount(HashMap<String, Object> map);

	ReportDTO penaltydetail(String member_id);

}
