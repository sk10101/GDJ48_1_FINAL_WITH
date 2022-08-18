package com.with.inquery.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.with.inquery.dto.InqueryDTO;

public interface InqueryDAO {

	int allCount(String idx);

	ArrayList<InqueryDTO> inqueryList(HashMap<String, Object> map);

	int inqueryWrite(HashMap<String, Object> map);

	HashMap<String, Object> inqueryDetail(int idx);

	int inqueryDelete(int idx);

	int inqueryUpdate(HashMap<String, Object> params);

	int adminAllCount();

	ArrayList<InqueryDTO> adminInqueryList(HashMap<String, Object> map);

	HashMap<String, Object> adminInqueryDetail(int idx);

	int admininqueryUpdate(HashMap<String, Object> params);

}
