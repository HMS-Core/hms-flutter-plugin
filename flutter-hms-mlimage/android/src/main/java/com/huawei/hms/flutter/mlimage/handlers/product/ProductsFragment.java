/*
    Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

package com.huawei.hms.flutter.mlimage.handlers.product;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.GridView;

import androidx.annotation.NonNull;

import com.huawei.hms.flutter.mlimage.R;
import com.huawei.hms.flutter.mlimage.logger.HMSLogger;
import com.huawei.hms.mlplugin.productvisionsearch.MLProductVisionSearchCapture;
import com.huawei.hms.mlsdk.productvisionsearch.MLProductVisionSearch;
import com.huawei.hms.mlsdk.productvisionsearch.MLVisionSearchProduct;

import org.json.JSONArray;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

public class ProductsFragment extends MLProductVisionSearchCapture.AbstractProductFragment<MLRealProductBean> {
    private static final String TAG = ProductsFragment.class.getSimpleName();
    private View root;
    private final Context context;
    private final MethodChannel.Result mResult;
    private final List<MLRealProductBean> mlProducts = new ArrayList<>();
    private BottomSheetAdapter adapter;
    private boolean isReplySubmitted = false;

    public ProductsFragment(Context context, MethodChannel.Result result) {
        this.context = context;
        this.mResult = result;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        root = View.inflate(getContext(), R.layout.fragment_products, null);
        initView();
        return root;
    }

    private void initView() {
        GridView gridView = root.findViewById(R.id.gv);
        gridView.setNumColumns(2);
        adapter = new BottomSheetAdapter(mlProducts, getContext());
        gridView.setAdapter(adapter);
    }

    @Override
    public List<MLRealProductBean> getProductList(List<MLProductVisionSearch> list) {
        return mLProductVisionSearchToTestBean(list);
    }

    @Override
    public void onResult(List<MLRealProductBean> list) {
        if (null == list) {
            Log.i(TAG, "null:" + mlProducts);
            return;
        }

        mlProducts.clear();
        mlProducts.addAll(list);
        adapter.notifyDataSetChanged();

        HMSLogger.getInstance(context).sendSingleEvent("analyzeProductWithPlugin");
        if (!isReplySubmitted) {
            isReplySubmitted = true;
            mResult.success(pluginProductResultToJSON(list).toString());
        }
    }

    @Override
    public boolean onError(Exception e) {
        return false;
    }

    private List<MLRealProductBean> mLProductVisionSearchToTestBean(List<MLProductVisionSearch> list) {
        List<MLRealProductBean> productBeans = new ArrayList<>();
        for (MLProductVisionSearch mlProductVisionSearch : list) {
            for (MLVisionSearchProduct product : mlProductVisionSearch.getProductList()) {
                MLRealProductBean productBean = new MLRealProductBean();
                productBean.setImgUrl(product.getImageList().get(0).getImageId());
                productBean.setId(product.getProductId());
                productBean.setOther(product.getProductUrl());
                productBeans.add(productBean);
            }
        }
        return productBeans;
    }

    public static JSONArray pluginProductResultToJSON(final List<MLRealProductBean> mlRealProductBean) {
        ArrayList<Map<String, Object>> beanList = new ArrayList<>();
        for (int i = 0; i < mlRealProductBean.size(); i++) {
            Map<String, Object> map = new HashMap<>();
            MLRealProductBean bean = mlRealProductBean.get(i);
            map.put("imgUrl", bean.getImgUrl());
            map.put("id", bean.getId());
            map.put("other", bean.getOther());
            beanList.add(map);
        }
        return new JSONArray(beanList);
    }
}