<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ProviderDetails;
use App\Services\ProviderDetailsService;
use Illuminate\Http\Request;

class ProviderDetailsController extends Controller
{
    /**
     * Display a listing of the resource.
     */

    protected ProviderDetailsService $providerDetailsService;

    public function __construct(ProviderDetailsService $providerDetailsService)
    {
        $this->providerDetailsService = $providerDetailsService;
    }

    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(ProviderDetails $providerDetails)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(ProviderDetails $providerDetails)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, ProviderDetails $providerDetails)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(ProviderDetails $providerDetails)
    {
        //
    }

    public function getProviderDetailsForDriver(int $driverId)
    {
        //
        return $this->providerDetailsService->getProviderDetailsForDriver($driverId);
    }
}
