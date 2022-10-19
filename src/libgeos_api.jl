using TimerOutputs: @timeit

macro timeitccall(args...)
    esc(
        :(@timeit "LibGEOS" @ccall($(args...)))
    )
end

const GEOSContextHandle_HS = Cvoid

const GEOSContextHandle_t = Ptr{GEOSContextHandle_HS}

# typedef void ( * GEOSMessageHandler ) ( const char * fmt , ... )
const GEOSMessageHandler = Ptr{Cvoid}

# typedef void ( * GEOSMessageHandler_r ) ( const char * message , void * userdata )
const GEOSMessageHandler_r = Ptr{Cvoid}

const GEOSGeom_t = Cvoid

const GEOSGeometry = GEOSGeom_t

const GEOSPrepGeom_t = Cvoid

const GEOSPreparedGeometry = GEOSPrepGeom_t

const GEOSCoordSeq_t = Cvoid

const GEOSCoordSequence = GEOSCoordSeq_t

const GEOSSTRtree_t = Cvoid

const GEOSSTRtree = GEOSSTRtree_t

const GEOSBufParams_t = Cvoid

const GEOSBufferParams = GEOSBufParams_t

const GEOSMakeValidParams_t = Cvoid

const GEOSMakeValidParams = GEOSMakeValidParams_t

const GEOSGeom = Ptr{GEOSGeometry}

const GEOSCoordSeq = Ptr{GEOSCoordSequence}

@cenum GEOSGeomTypes::UInt32 begin
    GEOS_POINT = 0
    GEOS_LINESTRING = 1
    GEOS_LINEARRING = 2
    GEOS_POLYGON = 3
    GEOS_MULTIPOINT = 4
    GEOS_MULTILINESTRING = 5
    GEOS_MULTIPOLYGON = 6
    GEOS_GEOMETRYCOLLECTION = 7
end

@cenum GEOSWKBByteOrders::UInt32 begin
    GEOS_WKB_XDR = 0
    GEOS_WKB_NDR = 1
end

@cenum GEOSWKBFlavors::UInt32 begin
    GEOS_WKB_EXTENDED = 1
    GEOS_WKB_ISO = 2
end

# typedef void ( * GEOSQueryCallback ) ( void * item , void * userdata )
const GEOSQueryCallback = Ptr{Cvoid}

# typedef int ( * GEOSDistanceCallback ) ( const void * item1 , const void * item2 , double * distance , void * userdata )
const GEOSDistanceCallback = Ptr{Cvoid}

# typedef int ( * GEOSTransformXYCallback ) ( double * x , double * y , void * userdata )
const GEOSTransformXYCallback = Ptr{Cvoid}

# typedef void ( GEOSInterruptCallback ) ( void )
const GEOSInterruptCallback = Cvoid

function GEOS_interruptRegisterCallback(cb)
    @timeitccall libgeos.GEOS_interruptRegisterCallback(cb::Ptr{Cvoid})::Ptr{Cvoid}
end

function GEOS_interruptRequest()
    @timeitccall libgeos.GEOS_interruptRequest()::Cvoid
end

function GEOS_interruptCancel()
    @timeitccall libgeos.GEOS_interruptCancel()::Cvoid
end

function GEOS_init_r()
    @timeitccall libgeos.GEOS_init_r()::GEOSContextHandle_t
end

function GEOS_finish_r(handle)
    @timeitccall libgeos.GEOS_finish_r(handle::GEOSContextHandle_t)::Cvoid
end

function GEOSContext_setNoticeHandler_r(extHandle, nf)
    @timeitccall libgeos.GEOSContext_setNoticeHandler_r(
        extHandle::GEOSContextHandle_t,
        nf::GEOSMessageHandler,
    )::GEOSMessageHandler
end

function GEOSContext_setErrorHandler_r(extHandle, ef)
    @timeitccall libgeos.GEOSContext_setErrorHandler_r(
        extHandle::GEOSContextHandle_t,
        ef::GEOSMessageHandler,
    )::GEOSMessageHandler
end

function GEOSContext_setNoticeMessageHandler_r(extHandle, nf, userData)
    @timeitccall libgeos.GEOSContext_setNoticeMessageHandler_r(
        extHandle::GEOSContextHandle_t,
        nf::GEOSMessageHandler_r,
        userData::Ptr{Cvoid},
    )::GEOSMessageHandler_r
end

function GEOSContext_setErrorMessageHandler_r(extHandle, ef, userData)
    @timeitccall libgeos.GEOSContext_setErrorMessageHandler_r(
        extHandle::GEOSContextHandle_t,
        ef::GEOSMessageHandler_r,
        userData::Ptr{Cvoid},
    )::GEOSMessageHandler_r
end

function GEOSCoordSeq_create_r(handle, size, dims)
    @timeitccall libgeos.GEOSCoordSeq_create_r(
        handle::GEOSContextHandle_t,
        size::Cuint,
        dims::Cuint,
    )::Ptr{GEOSCoordSequence}
end

function GEOSCoordSeq_copyFromBuffer_r(handle, buf, size, hasZ, hasM)
    @timeitccall libgeos.GEOSCoordSeq_copyFromBuffer_r(
        handle::GEOSContextHandle_t,
        buf::Ptr{Cdouble},
        size::Cuint,
        hasZ::Cint,
        hasM::Cint,
    )::Ptr{GEOSCoordSequence}
end

function GEOSCoordSeq_copyFromArrays_r(handle, x, y, z, m, size)
    @timeitccall libgeos.GEOSCoordSeq_copyFromArrays_r(
        handle::GEOSContextHandle_t,
        x::Ptr{Cdouble},
        y::Ptr{Cdouble},
        z::Ptr{Cdouble},
        m::Ptr{Cdouble},
        size::Cuint,
    )::Ptr{GEOSCoordSequence}
end

function GEOSCoordSeq_copyToBuffer_r(handle, s, buf, hasZ, hasM)
    @timeitccall libgeos.GEOSCoordSeq_copyToBuffer_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        buf::Ptr{Cdouble},
        hasZ::Cint,
        hasM::Cint,
    )::Cint
end

function GEOSCoordSeq_copyToArrays_r(handle, s, x, y, z, m)
    @timeitccall libgeos.GEOSCoordSeq_copyToArrays_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        x::Ptr{Cdouble},
        y::Ptr{Cdouble},
        z::Ptr{Cdouble},
        m::Ptr{Cdouble},
    )::Cint
end

function GEOSCoordSeq_clone_r(handle, s)
    @timeitccall libgeos.GEOSCoordSeq_clone_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
    )::Ptr{GEOSCoordSequence}
end

function GEOSCoordSeq_destroy_r(handle, s)
    @timeitccall libgeos.GEOSCoordSeq_destroy_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
    )::Cvoid
end

function GEOSCoordSeq_setX_r(handle, s, idx, val)
    @timeitccall libgeos.GEOSCoordSeq_setX_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        val::Cdouble,
    )::Cint
end

function GEOSCoordSeq_setY_r(handle, s, idx, val)
    @timeitccall libgeos.GEOSCoordSeq_setY_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        val::Cdouble,
    )::Cint
end

function GEOSCoordSeq_setZ_r(handle, s, idx, val)
    @timeitccall libgeos.GEOSCoordSeq_setZ_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        val::Cdouble,
    )::Cint
end

function GEOSCoordSeq_setXY_r(handle, s, idx, x, y)
    @timeitccall libgeos.GEOSCoordSeq_setXY_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        x::Cdouble,
        y::Cdouble,
    )::Cint
end

function GEOSCoordSeq_setXYZ_r(handle, s, idx, x, y, z)
    @timeitccall libgeos.GEOSCoordSeq_setXYZ_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        x::Cdouble,
        y::Cdouble,
        z::Cdouble,
    )::Cint
end

function GEOSCoordSeq_setOrdinate_r(handle, s, idx, dim, val)
    @timeitccall libgeos.GEOSCoordSeq_setOrdinate_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        dim::Cuint,
        val::Cdouble,
    )::Cint
end

function GEOSCoordSeq_getX_r(handle, s, idx, val)
    @timeitccall libgeos.GEOSCoordSeq_getX_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        val::Ptr{Cdouble},
    )::Cint
end

function GEOSCoordSeq_getY_r(handle, s, idx, val)
    @timeitccall libgeos.GEOSCoordSeq_getY_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        val::Ptr{Cdouble},
    )::Cint
end

function GEOSCoordSeq_getZ_r(handle, s, idx, val)
    @timeitccall libgeos.GEOSCoordSeq_getZ_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        val::Ptr{Cdouble},
    )::Cint
end

function GEOSCoordSeq_getXY_r(handle, s, idx, x, y)
    @timeitccall libgeos.GEOSCoordSeq_getXY_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        x::Ptr{Cdouble},
        y::Ptr{Cdouble},
    )::Cint
end

function GEOSCoordSeq_getXYZ_r(handle, s, idx, x, y, z)
    @timeitccall libgeos.GEOSCoordSeq_getXYZ_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        x::Ptr{Cdouble},
        y::Ptr{Cdouble},
        z::Ptr{Cdouble},
    )::Cint
end

function GEOSCoordSeq_getOrdinate_r(handle, s, idx, dim, val)
    @timeitccall libgeos.GEOSCoordSeq_getOrdinate_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        dim::Cuint,
        val::Ptr{Cdouble},
    )::Cint
end

function GEOSCoordSeq_getSize_r(handle, s, size)
    @timeitccall libgeos.GEOSCoordSeq_getSize_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        size::Ptr{Cuint},
    )::Cint
end

function GEOSCoordSeq_getDimensions_r(handle, s, dims)
    @timeitccall libgeos.GEOSCoordSeq_getDimensions_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        dims::Ptr{Cuint},
    )::Cint
end

function GEOSCoordSeq_isCCW_r(handle, s, is_ccw)
    @timeitccall libgeos.GEOSCoordSeq_isCCW_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
        is_ccw::Cstring,
    )::Cint
end

function GEOSProject_r(handle, line, point)
    @timeitccall libgeos.GEOSProject_r(
        handle::GEOSContextHandle_t,
        line::Ptr{GEOSGeometry},
        point::Ptr{GEOSGeometry},
    )::Cdouble
end

function GEOSInterpolate_r(handle, line, d)
    @timeitccall libgeos.GEOSInterpolate_r(
        handle::GEOSContextHandle_t,
        line::Ptr{GEOSGeometry},
        d::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSProjectNormalized_r(handle, g, p)
    @timeitccall libgeos.GEOSProjectNormalized_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        p::Ptr{GEOSGeometry},
    )::Cdouble
end

function GEOSInterpolateNormalized_r(handle, g, d)
    @timeitccall libgeos.GEOSInterpolateNormalized_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        d::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSBuffer_r(handle, g, width, quadsegs)
    @timeitccall libgeos.GEOSBuffer_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        width::Cdouble,
        quadsegs::Cint,
    )::Ptr{GEOSGeometry}
end

@cenum GEOSBufCapStyles::UInt32 begin
    GEOSBUF_CAP_ROUND = 1
    GEOSBUF_CAP_FLAT = 2
    GEOSBUF_CAP_SQUARE = 3
end

@cenum GEOSBufJoinStyles::UInt32 begin
    GEOSBUF_JOIN_ROUND = 1
    GEOSBUF_JOIN_MITRE = 2
    GEOSBUF_JOIN_BEVEL = 3
end

function GEOSBufferParams_create_r(handle)
    @timeitccall libgeos.GEOSBufferParams_create_r(
        handle::GEOSContextHandle_t,
    )::Ptr{GEOSBufferParams}
end

function GEOSBufferParams_destroy_r(handle, parms)
    @timeitccall libgeos.GEOSBufferParams_destroy_r(
        handle::GEOSContextHandle_t,
        parms::Ptr{GEOSBufferParams},
    )::Cvoid
end

function GEOSBufferParams_setEndCapStyle_r(handle, p, style)
    @timeitccall libgeos.GEOSBufferParams_setEndCapStyle_r(
        handle::GEOSContextHandle_t,
        p::Ptr{GEOSBufferParams},
        style::Cint,
    )::Cint
end

function GEOSBufferParams_setJoinStyle_r(handle, p, joinStyle)
    @timeitccall libgeos.GEOSBufferParams_setJoinStyle_r(
        handle::GEOSContextHandle_t,
        p::Ptr{GEOSBufferParams},
        joinStyle::Cint,
    )::Cint
end

function GEOSBufferParams_setMitreLimit_r(handle, p, mitreLimit)
    @timeitccall libgeos.GEOSBufferParams_setMitreLimit_r(
        handle::GEOSContextHandle_t,
        p::Ptr{GEOSBufferParams},
        mitreLimit::Cdouble,
    )::Cint
end

function GEOSBufferParams_setQuadrantSegments_r(handle, p, quadSegs)
    @timeitccall libgeos.GEOSBufferParams_setQuadrantSegments_r(
        handle::GEOSContextHandle_t,
        p::Ptr{GEOSBufferParams},
        quadSegs::Cint,
    )::Cint
end

function GEOSBufferParams_setSingleSided_r(handle, p, singleSided)
    @timeitccall libgeos.GEOSBufferParams_setSingleSided_r(
        handle::GEOSContextHandle_t,
        p::Ptr{GEOSBufferParams},
        singleSided::Cint,
    )::Cint
end

function GEOSBufferWithParams_r(handle, g, p, width)
    @timeitccall libgeos.GEOSBufferWithParams_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        p::Ptr{GEOSBufferParams},
        width::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSBufferWithStyle_r(
    handle,
    g,
    width,
    quadsegs,
    endCapStyle,
    joinStyle,
    mitreLimit,
)
    @timeitccall libgeos.GEOSBufferWithStyle_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        width::Cdouble,
        quadsegs::Cint,
        endCapStyle::Cint,
        joinStyle::Cint,
        mitreLimit::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSDensify_r(handle, g, tolerance)
    @timeitccall libgeos.GEOSDensify_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        tolerance::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSOffsetCurve_r(handle, g, width, quadsegs, joinStyle, mitreLimit)
    @timeitccall libgeos.GEOSOffsetCurve_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        width::Cdouble,
        quadsegs::Cint,
        joinStyle::Cint,
        mitreLimit::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_createPoint_r(handle, s)
    @timeitccall libgeos.GEOSGeom_createPoint_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_createPointFromXY_r(handle, x, y)
    @timeitccall libgeos.GEOSGeom_createPointFromXY_r(
        handle::GEOSContextHandle_t,
        x::Cdouble,
        y::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_createEmptyPoint_r(handle)
    @timeitccall libgeos.GEOSGeom_createEmptyPoint_r(
        handle::GEOSContextHandle_t,
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_createLinearRing_r(handle, s)
    @timeitccall libgeos.GEOSGeom_createLinearRing_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_createLineString_r(handle, s)
    @timeitccall libgeos.GEOSGeom_createLineString_r(
        handle::GEOSContextHandle_t,
        s::Ptr{GEOSCoordSequence},
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_createEmptyLineString_r(handle)
    @timeitccall libgeos.GEOSGeom_createEmptyLineString_r(
        handle::GEOSContextHandle_t,
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_createEmptyPolygon_r(handle)
    @timeitccall libgeos.GEOSGeom_createEmptyPolygon_r(
        handle::GEOSContextHandle_t,
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_createPolygon_r(handle, shell, holes, nholes)
    @timeitccall libgeos.GEOSGeom_createPolygon_r(
        handle::GEOSContextHandle_t,
        shell::Ptr{GEOSGeometry},
        holes::Ptr{Ptr{GEOSGeometry}},
        nholes::Cuint,
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_createCollection_r(handle, type, geoms, ngeoms)
    @timeitccall libgeos.GEOSGeom_createCollection_r(
        handle::GEOSContextHandle_t,
        type::Cint,
        geoms::Ptr{Ptr{GEOSGeometry}},
        ngeoms::Cuint,
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_createEmptyCollection_r(handle, type)
    @timeitccall libgeos.GEOSGeom_createEmptyCollection_r(
        handle::GEOSContextHandle_t,
        type::Cint,
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_createRectangle_r(handle, xmin, ymin, xmax, ymax)
    @timeitccall libgeos.GEOSGeom_createRectangle_r(
        handle::GEOSContextHandle_t,
        xmin::Cdouble,
        ymin::Cdouble,
        xmax::Cdouble,
        ymax::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_clone_r(handle, g)
    @timeitccall libgeos.GEOSGeom_clone_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_destroy_r(handle, g)
    @timeitccall libgeos.GEOSGeom_destroy_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Cvoid
end

function GEOSEnvelope_r(handle, g)
    @timeitccall libgeos.GEOSEnvelope_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSIntersection_r(handle, g1, g2)
    @timeitccall libgeos.GEOSIntersection_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSIntersectionPrec_r(handle, g1, g2, gridSize)
    @timeitccall libgeos.GEOSIntersectionPrec_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        gridSize::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSConvexHull_r(handle, g)
    @timeitccall libgeos.GEOSConvexHull_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSConcaveHull_r(handle, g, ratio, allowHoles)
    @timeitccall libgeos.GEOSConcaveHull_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        ratio::Cdouble,
        allowHoles::Cuint,
    )::Ptr{GEOSGeometry}
end

function GEOSPolygonHullSimplify_r(handle, g, isOuter, vertexNumFraction)
    @timeitccall libgeos.GEOSPolygonHullSimplify_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        isOuter::Cuint,
        vertexNumFraction::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSPolygonHullSimplifyMode_r(handle, g, isOuter, parameterMode, parameter)
    @timeitccall libgeos.GEOSPolygonHullSimplifyMode_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        isOuter::Cuint,
        parameterMode::Cuint,
        parameter::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSConcaveHullOfPolygons_r(handle, g, lengthRatio, isTight, isHolesAllowed)
    @timeitccall libgeos.GEOSConcaveHullOfPolygons_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        lengthRatio::Cdouble,
        isTight::Cuint,
        isHolesAllowed::Cuint,
    )::Ptr{GEOSGeometry}
end

function GEOSMinimumRotatedRectangle_r(handle, g)
    @timeitccall libgeos.GEOSMinimumRotatedRectangle_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSMaximumInscribedCircle_r(handle, g, tolerance)
    @timeitccall libgeos.GEOSMaximumInscribedCircle_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        tolerance::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSLargestEmptyCircle_r(handle, g, boundary, tolerance)
    @timeitccall libgeos.GEOSLargestEmptyCircle_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        boundary::Ptr{GEOSGeometry},
        tolerance::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSMinimumWidth_r(handle, g)
    @timeitccall libgeos.GEOSMinimumWidth_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSMinimumClearanceLine_r(handle, g)
    @timeitccall libgeos.GEOSMinimumClearanceLine_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSMinimumClearance_r(handle, g, distance)
    @timeitccall libgeos.GEOSMinimumClearance_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        distance::Ptr{Cdouble},
    )::Cint
end

function GEOSDifference_r(handle, g1, g2)
    @timeitccall libgeos.GEOSDifference_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSDifferencePrec_r(handle, g1, g2, gridSize)
    @timeitccall libgeos.GEOSDifferencePrec_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        gridSize::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSSymDifference_r(handle, g1, g2)
    @timeitccall libgeos.GEOSSymDifference_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSSymDifferencePrec_r(handle, g1, g2, gridSize)
    @timeitccall libgeos.GEOSSymDifferencePrec_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        gridSize::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSBoundary_r(handle, g)
    @timeitccall libgeos.GEOSBoundary_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSUnion_r(handle, g1, g2)
    @timeitccall libgeos.GEOSUnion_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSUnionPrec_r(handle, g1, g2, gridSize)
    @timeitccall libgeos.GEOSUnionPrec_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        gridSize::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSUnaryUnion_r(handle, g)
    @timeitccall libgeos.GEOSUnaryUnion_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSUnaryUnionPrec_r(handle, g, gridSize)
    @timeitccall libgeos.GEOSUnaryUnionPrec_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        gridSize::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSCoverageUnion_r(handle, g)
    @timeitccall libgeos.GEOSCoverageUnion_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSPointOnSurface_r(handle, g)
    @timeitccall libgeos.GEOSPointOnSurface_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSGetCentroid_r(handle, g)
    @timeitccall libgeos.GEOSGetCentroid_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSMinimumBoundingCircle_r(handle, g, radius, center)
    @timeitccall libgeos.GEOSMinimumBoundingCircle_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        radius::Ptr{Cdouble},
        center::Ptr{Ptr{GEOSGeometry}},
    )::Ptr{GEOSGeometry}
end

function GEOSNode_r(handle, g)
    @timeitccall libgeos.GEOSNode_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSClipByRect_r(handle, g, xmin, ymin, xmax, ymax)
    @timeitccall libgeos.GEOSClipByRect_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        xmin::Cdouble,
        ymin::Cdouble,
        xmax::Cdouble,
        ymax::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSPolygonize_r(handle, geoms, ngeoms)
    @timeitccall libgeos.GEOSPolygonize_r(
        handle::GEOSContextHandle_t,
        geoms::Ptr{Ptr{GEOSGeometry}},
        ngeoms::Cuint,
    )::Ptr{GEOSGeometry}
end

function GEOSPolygonize_valid_r(handle, geoms, ngems)
    @timeitccall libgeos.GEOSPolygonize_valid_r(
        handle::GEOSContextHandle_t,
        geoms::Ptr{Ptr{GEOSGeometry}},
        ngems::Cuint,
    )::Ptr{GEOSGeometry}
end

function GEOSPolygonizer_getCutEdges_r(handle, geoms, ngeoms)
    @timeitccall libgeos.GEOSPolygonizer_getCutEdges_r(
        handle::GEOSContextHandle_t,
        geoms::Ptr{Ptr{GEOSGeometry}},
        ngeoms::Cuint,
    )::Ptr{GEOSGeometry}
end

function GEOSPolygonize_full_r(handle, input, cuts, dangles, invalidRings)
    @timeitccall libgeos.GEOSPolygonize_full_r(
        handle::GEOSContextHandle_t,
        input::Ptr{GEOSGeometry},
        cuts::Ptr{Ptr{GEOSGeometry}},
        dangles::Ptr{Ptr{GEOSGeometry}},
        invalidRings::Ptr{Ptr{GEOSGeometry}},
    )::Ptr{GEOSGeometry}
end

function GEOSBuildArea_r(handle, g)
    @timeitccall libgeos.GEOSBuildArea_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSLineMerge_r(handle, g)
    @timeitccall libgeos.GEOSLineMerge_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSLineMergeDirected_r(handle, g)
    @timeitccall libgeos.GEOSLineMergeDirected_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSReverse_r(handle, g)
    @timeitccall libgeos.GEOSReverse_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSSimplify_r(handle, g, tolerance)
    @timeitccall libgeos.GEOSSimplify_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        tolerance::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSTopologyPreserveSimplify_r(handle, g, tolerance)
    @timeitccall libgeos.GEOSTopologyPreserveSimplify_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        tolerance::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_extractUniquePoints_r(handle, g)
    @timeitccall libgeos.GEOSGeom_extractUniquePoints_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSSharedPaths_r(handle, g1, g2)
    @timeitccall libgeos.GEOSSharedPaths_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSSnap_r(handle, g1, g2, tolerance)
    @timeitccall libgeos.GEOSSnap_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        tolerance::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSDelaunayTriangulation_r(handle, g, tolerance, onlyEdges)
    @timeitccall libgeos.GEOSDelaunayTriangulation_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        tolerance::Cdouble,
        onlyEdges::Cint,
    )::Ptr{GEOSGeometry}
end

function GEOSConstrainedDelaunayTriangulation_r(handle, g)
    @timeitccall libgeos.GEOSConstrainedDelaunayTriangulation_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSVoronoiDiagram_r(extHandle, g, env, tolerance, onlyEdges)
    @timeitccall libgeos.GEOSVoronoiDiagram_r(
        extHandle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        env::Ptr{GEOSGeometry},
        tolerance::Cdouble,
        onlyEdges::Cint,
    )::Ptr{GEOSGeometry}
end

function GEOSSegmentIntersection_r(
    extHandle,
    ax0,
    ay0,
    ax1,
    ay1,
    bx0,
    by0,
    bx1,
    by1,
    cx,
    cy,
)
    @timeitccall libgeos.GEOSSegmentIntersection_r(
        extHandle::GEOSContextHandle_t,
        ax0::Cdouble,
        ay0::Cdouble,
        ax1::Cdouble,
        ay1::Cdouble,
        bx0::Cdouble,
        by0::Cdouble,
        bx1::Cdouble,
        by1::Cdouble,
        cx::Ptr{Cdouble},
        cy::Ptr{Cdouble},
    )::Cint
end

function GEOSDisjoint_r(handle, g1, g2)
    @timeitccall libgeos.GEOSDisjoint_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSTouches_r(handle, g1, g2)
    @timeitccall libgeos.GEOSTouches_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSIntersects_r(handle, g1, g2)
    @timeitccall libgeos.GEOSIntersects_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSCrosses_r(handle, g1, g2)
    @timeitccall libgeos.GEOSCrosses_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSWithin_r(handle, g1, g2)
    @timeitccall libgeos.GEOSWithin_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSContains_r(handle, g1, g2)
    @timeitccall libgeos.GEOSContains_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSOverlaps_r(handle, g1, g2)
    @timeitccall libgeos.GEOSOverlaps_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSEquals_r(handle, g1, g2)
    @timeitccall libgeos.GEOSEquals_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSEqualsExact_r(handle, g1, g2, tolerance)
    @timeitccall libgeos.GEOSEqualsExact_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        tolerance::Cdouble,
    )::Cchar
end

function GEOSCovers_r(handle, g1, g2)
    @timeitccall libgeos.GEOSCovers_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSCoveredBy_r(handle, g1, g2)
    @timeitccall libgeos.GEOSCoveredBy_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPrepare_r(handle, g)
    @timeitccall libgeos.GEOSPrepare_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSPreparedGeometry}
end

function GEOSPreparedGeom_destroy_r(handle, g)
    @timeitccall libgeos.GEOSPreparedGeom_destroy_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSPreparedGeometry},
    )::Cvoid
end

function GEOSPreparedContains_r(handle, pg1, g2)
    @timeitccall libgeos.GEOSPreparedContains_r(
        handle::GEOSContextHandle_t,
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedContainsProperly_r(handle, pg1, g2)
    @timeitccall libgeos.GEOSPreparedContainsProperly_r(
        handle::GEOSContextHandle_t,
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedCoveredBy_r(handle, pg1, g2)
    @timeitccall libgeos.GEOSPreparedCoveredBy_r(
        handle::GEOSContextHandle_t,
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedCovers_r(handle, pg1, g2)
    @timeitccall libgeos.GEOSPreparedCovers_r(
        handle::GEOSContextHandle_t,
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedCrosses_r(handle, pg1, g2)
    @timeitccall libgeos.GEOSPreparedCrosses_r(
        handle::GEOSContextHandle_t,
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedDisjoint_r(handle, pg1, g2)
    @timeitccall libgeos.GEOSPreparedDisjoint_r(
        handle::GEOSContextHandle_t,
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedIntersects_r(handle, pg1, g2)
    @timeitccall libgeos.GEOSPreparedIntersects_r(
        handle::GEOSContextHandle_t,
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedOverlaps_r(handle, pg1, g2)
    @timeitccall libgeos.GEOSPreparedOverlaps_r(
        handle::GEOSContextHandle_t,
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedTouches_r(handle, pg1, g2)
    @timeitccall libgeos.GEOSPreparedTouches_r(
        handle::GEOSContextHandle_t,
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedWithin_r(handle, pg1, g2)
    @timeitccall libgeos.GEOSPreparedWithin_r(
        handle::GEOSContextHandle_t,
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedNearestPoints_r(handle, pg1, g2)
    @timeitccall libgeos.GEOSPreparedNearestPoints_r(
        handle::GEOSContextHandle_t,
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Ptr{GEOSCoordSequence}
end

function GEOSPreparedDistance_r(handle, pg1, g2, dist)
    @timeitccall libgeos.GEOSPreparedDistance_r(
        handle::GEOSContextHandle_t,
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
        dist::Ptr{Cdouble},
    )::Cint
end

function GEOSPreparedDistanceWithin_r(handle, pg1, g2, dist)
    @timeitccall libgeos.GEOSPreparedDistanceWithin_r(
        handle::GEOSContextHandle_t,
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
        dist::Cdouble,
    )::Cchar
end

function GEOSSTRtree_create_r(handle, nodeCapacity)
    @timeitccall libgeos.GEOSSTRtree_create_r(
        handle::GEOSContextHandle_t,
        nodeCapacity::Csize_t,
    )::Ptr{GEOSSTRtree}
end

function GEOSSTRtree_insert_r(handle, tree, g, item)
    @timeitccall libgeos.GEOSSTRtree_insert_r(
        handle::GEOSContextHandle_t,
        tree::Ptr{GEOSSTRtree},
        g::Ptr{GEOSGeometry},
        item::Ptr{Cvoid},
    )::Cvoid
end

function GEOSSTRtree_query_r(handle, tree, g, callback, userdata)
    @timeitccall libgeos.GEOSSTRtree_query_r(
        handle::GEOSContextHandle_t,
        tree::Ptr{GEOSSTRtree},
        g::Ptr{GEOSGeometry},
        callback::GEOSQueryCallback,
        userdata::Ptr{Cvoid},
    )::Cvoid
end

function GEOSSTRtree_nearest_r(handle, tree, geom)
    @timeitccall libgeos.GEOSSTRtree_nearest_r(
        handle::GEOSContextHandle_t,
        tree::Ptr{GEOSSTRtree},
        geom::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSSTRtree_nearest_generic_r(
    handle,
    tree,
    item,
    itemEnvelope,
    distancefn,
    userdata,
)
    @timeitccall libgeos.GEOSSTRtree_nearest_generic_r(
        handle::GEOSContextHandle_t,
        tree::Ptr{GEOSSTRtree},
        item::Ptr{Cvoid},
        itemEnvelope::Ptr{GEOSGeometry},
        distancefn::GEOSDistanceCallback,
        userdata::Ptr{Cvoid},
    )::Ptr{Cvoid}
end

function GEOSSTRtree_iterate_r(handle, tree, callback, userdata)
    @timeitccall libgeos.GEOSSTRtree_iterate_r(
        handle::GEOSContextHandle_t,
        tree::Ptr{GEOSSTRtree},
        callback::GEOSQueryCallback,
        userdata::Ptr{Cvoid},
    )::Cvoid
end

function GEOSSTRtree_remove_r(handle, tree, g, item)
    @timeitccall libgeos.GEOSSTRtree_remove_r(
        handle::GEOSContextHandle_t,
        tree::Ptr{GEOSSTRtree},
        g::Ptr{GEOSGeometry},
        item::Ptr{Cvoid},
    )::Cchar
end

function GEOSSTRtree_destroy_r(handle, tree)
    @timeitccall libgeos.GEOSSTRtree_destroy_r(
        handle::GEOSContextHandle_t,
        tree::Ptr{GEOSSTRtree},
    )::Cvoid
end

function GEOSisEmpty_r(handle, g)
    @timeitccall libgeos.GEOSisEmpty_r(handle::GEOSContextHandle_t, g::Ptr{GEOSGeometry})::Cchar
end

function GEOSisSimple_r(handle, g)
    @timeitccall libgeos.GEOSisSimple_r(handle::GEOSContextHandle_t, g::Ptr{GEOSGeometry})::Cchar
end

function GEOSisRing_r(handle, g)
    @timeitccall libgeos.GEOSisRing_r(handle::GEOSContextHandle_t, g::Ptr{GEOSGeometry})::Cchar
end

function GEOSHasZ_r(handle, g)
    @timeitccall libgeos.GEOSHasZ_r(handle::GEOSContextHandle_t, g::Ptr{GEOSGeometry})::Cchar
end

function GEOSisClosed_r(handle, g)
    @timeitccall libgeos.GEOSisClosed_r(handle::GEOSContextHandle_t, g::Ptr{GEOSGeometry})::Cchar
end

@cenum GEOSRelateBoundaryNodeRules::UInt32 begin
    GEOSRELATE_BNR_MOD2 = 1
    GEOSRELATE_BNR_OGC = 1
    GEOSRELATE_BNR_ENDPOINT = 2
    GEOSRELATE_BNR_MULTIVALENT_ENDPOINT = 3
    GEOSRELATE_BNR_MONOVALENT_ENDPOINT = 4
end

function GEOSRelatePattern_r(handle, g1, g2, pat)
    @timeitccall libgeos.GEOSRelatePattern_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        pat::Cstring,
    )::Cchar
end

function GEOSRelate_r(handle, g1, g2)
    string_copy_free(
        @timeitccall(
            libgeos.GEOSRelate_r(
                handle::GEOSContextHandle_t,
                g1::Ptr{GEOSGeometry},
                g2::Ptr{GEOSGeometry},
            )::Cstring
        ),
        handle,
    )
end

function GEOSRelatePatternMatch_r(handle, mat, pat)
    @timeitccall libgeos.GEOSRelatePatternMatch_r(
        handle::GEOSContextHandle_t,
        mat::Cstring,
        pat::Cstring,
    )::Cchar
end

function GEOSRelateBoundaryNodeRule_r(handle, g1, g2, bnr)
    string_copy_free(
        @timeitccall(
            libgeos.GEOSRelateBoundaryNodeRule_r(
                handle::GEOSContextHandle_t,
                g1::Ptr{GEOSGeometry},
                g2::Ptr{GEOSGeometry},
                bnr::Cint,
            )::Cstring
        ),
        handle,
    )
end

@cenum GEOSValidFlags::UInt32 begin
    GEOSVALID_ALLOW_SELFTOUCHING_RING_FORMING_HOLE = 1
end

function GEOSisValid_r(handle, g)
    @timeitccall libgeos.GEOSisValid_r(handle::GEOSContextHandle_t, g::Ptr{GEOSGeometry})::Cchar
end

function GEOSisValidReason_r(handle, g)
    string_copy_free(
        @timeitccall(
            libgeos.GEOSisValidReason_r(
                handle::GEOSContextHandle_t,
                g::Ptr{GEOSGeometry},
            )::Cstring
        ),
        handle,
    )
end

function GEOSisValidDetail_r(handle, g, flags, reason, location)
    @timeitccall libgeos.GEOSisValidDetail_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        flags::Cint,
        reason::Ptr{Cstring},
        location::Ptr{Ptr{GEOSGeometry}},
    )::Cchar
end

@cenum GEOSMakeValidMethods::UInt32 begin
    GEOS_MAKE_VALID_LINEWORK = 0
    GEOS_MAKE_VALID_STRUCTURE = 1
end

function GEOSMakeValidParams_create_r(extHandle)
    @timeitccall libgeos.GEOSMakeValidParams_create_r(
        extHandle::GEOSContextHandle_t,
    )::Ptr{GEOSMakeValidParams}
end

function GEOSMakeValidParams_destroy_r(handle, parms)
    @timeitccall libgeos.GEOSMakeValidParams_destroy_r(
        handle::GEOSContextHandle_t,
        parms::Ptr{GEOSMakeValidParams},
    )::Cvoid
end

function GEOSMakeValidParams_setKeepCollapsed_r(handle, p, style)
    @timeitccall libgeos.GEOSMakeValidParams_setKeepCollapsed_r(
        handle::GEOSContextHandle_t,
        p::Ptr{GEOSMakeValidParams},
        style::Cint,
    )::Cint
end

function GEOSMakeValidParams_setMethod_r(handle, p, method)
    @timeitccall libgeos.GEOSMakeValidParams_setMethod_r(
        handle::GEOSContextHandle_t,
        p::Ptr{GEOSMakeValidParams},
        method::GEOSMakeValidMethods,
    )::Cint
end

function GEOSMakeValid_r(handle, g)
    @timeitccall libgeos.GEOSMakeValid_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSMakeValidWithParams_r(handle, g, makeValidParams)
    @timeitccall libgeos.GEOSMakeValidWithParams_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        makeValidParams::Ptr{GEOSMakeValidParams},
    )::Ptr{GEOSGeometry}
end

function GEOSRemoveRepeatedPoints_r(handle, g, tolerance)
    @timeitccall libgeos.GEOSRemoveRepeatedPoints_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        tolerance::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSGeomType_r(handle, g)
    string_copy_free(
        @timeitccall(
            libgeos.GEOSGeomType_r(
                handle::GEOSContextHandle_t,
                g::Ptr{GEOSGeometry},
            )::Cstring
        ),
        handle,
    )
end

function GEOSGeomTypeId_r(handle, g)
    @timeitccall libgeos.GEOSGeomTypeId_r(handle::GEOSContextHandle_t, g::Ptr{GEOSGeometry})::Cint
end

function GEOSGetSRID_r(handle, g)
    @timeitccall libgeos.GEOSGetSRID_r(handle::GEOSContextHandle_t, g::Ptr{GEOSGeometry})::Cint
end

function GEOSSetSRID_r(handle, g, SRID)
    @timeitccall libgeos.GEOSSetSRID_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        SRID::Cint,
    )::Cvoid
end

function GEOSGeom_getUserData_r(handle, g)
    @timeitccall libgeos.GEOSGeom_getUserData_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{Cvoid}
end

function GEOSGeom_setUserData_r(handle, g, userData)
    @timeitccall libgeos.GEOSGeom_setUserData_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        userData::Ptr{Cvoid},
    )::Cvoid
end

function GEOSGetNumGeometries_r(handle, g)
    @timeitccall libgeos.GEOSGetNumGeometries_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Cint
end

function GEOSGetGeometryN_r(handle, g, n)
    @timeitccall libgeos.GEOSGetGeometryN_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        n::Cint,
    )::Ptr{GEOSGeometry}
end

function GEOSNormalize_r(handle, g)
    @timeitccall libgeos.GEOSNormalize_r(handle::GEOSContextHandle_t, g::Ptr{GEOSGeometry})::Cint
end

@cenum GEOSPrecisionRules::UInt32 begin
    GEOS_PREC_VALID_OUTPUT = 0
    GEOS_PREC_NO_TOPO = 1
    GEOS_PREC_KEEP_COLLAPSED = 2
end

function GEOSGeom_setPrecision_r(handle, g, gridSize, flags)
    @timeitccall libgeos.GEOSGeom_setPrecision_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        gridSize::Cdouble,
        flags::Cint,
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_getPrecision_r(handle, g)
    @timeitccall libgeos.GEOSGeom_getPrecision_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Cdouble
end

function GEOSGetNumInteriorRings_r(handle, g)
    @timeitccall libgeos.GEOSGetNumInteriorRings_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Cint
end

function GEOSGeomGetNumPoints_r(handle, g)
    @timeitccall libgeos.GEOSGeomGetNumPoints_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Cint
end

function GEOSGeomGetX_r(handle, g, x)
    @timeitccall libgeos.GEOSGeomGetX_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        x::Ptr{Cdouble},
    )::Cint
end

function GEOSGeomGetY_r(handle, g, y)
    @timeitccall libgeos.GEOSGeomGetY_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        y::Ptr{Cdouble},
    )::Cint
end

function GEOSGeomGetZ_r(handle, g, z)
    @timeitccall libgeos.GEOSGeomGetZ_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        z::Ptr{Cdouble},
    )::Cint
end

function GEOSGetInteriorRingN_r(handle, g, n)
    @timeitccall libgeos.GEOSGetInteriorRingN_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        n::Cint,
    )::Ptr{GEOSGeometry}
end

function GEOSGetExteriorRing_r(handle, g)
    @timeitccall libgeos.GEOSGetExteriorRing_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSGetNumCoordinates_r(handle, g)
    @timeitccall libgeos.GEOSGetNumCoordinates_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Cint
end

function GEOSGeom_getCoordSeq_r(handle, g)
    @timeitccall libgeos.GEOSGeom_getCoordSeq_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSCoordSequence}
end

function GEOSGeom_getDimensions_r(handle, g)
    @timeitccall libgeos.GEOSGeom_getDimensions_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Cint
end

function GEOSGeom_getCoordinateDimension_r(handle, g)
    @timeitccall libgeos.GEOSGeom_getCoordinateDimension_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Cint
end

function GEOSGeom_getXMin_r(handle, g, value)
    @timeitccall libgeos.GEOSGeom_getXMin_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        value::Ptr{Cdouble},
    )::Cint
end

function GEOSGeom_getYMin_r(handle, g, value)
    @timeitccall libgeos.GEOSGeom_getYMin_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        value::Ptr{Cdouble},
    )::Cint
end

function GEOSGeom_getXMax_r(handle, g, value)
    @timeitccall libgeos.GEOSGeom_getXMax_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        value::Ptr{Cdouble},
    )::Cint
end

function GEOSGeom_getYMax_r(handle, g, value)
    @timeitccall libgeos.GEOSGeom_getYMax_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        value::Ptr{Cdouble},
    )::Cint
end

function GEOSGeom_getExtent_r(handle, g, xmin, ymin, xmax, ymax)
    @timeitccall libgeos.GEOSGeom_getExtent_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        xmin::Ptr{Cdouble},
        ymin::Ptr{Cdouble},
        xmax::Ptr{Cdouble},
        ymax::Ptr{Cdouble},
    )::Cint
end

function GEOSGeomGetPointN_r(handle, g, n)
    @timeitccall libgeos.GEOSGeomGetPointN_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        n::Cint,
    )::Ptr{GEOSGeometry}
end

function GEOSGeomGetStartPoint_r(handle, g)
    @timeitccall libgeos.GEOSGeomGetStartPoint_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSGeomGetEndPoint_r(handle, g)
    @timeitccall libgeos.GEOSGeomGetEndPoint_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSArea_r(handle, g, area)
    @timeitccall libgeos.GEOSArea_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        area::Ptr{Cdouble},
    )::Cint
end

function GEOSLength_r(handle, g, length)
    @timeitccall libgeos.GEOSLength_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        length::Ptr{Cdouble},
    )::Cint
end

function GEOSDistance_r(handle, g1, g2, dist)
    @timeitccall libgeos.GEOSDistance_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        dist::Ptr{Cdouble},
    )::Cint
end

function GEOSDistanceWithin_r(handle, g1, g2, dist)
    @timeitccall libgeos.GEOSDistanceWithin_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        dist::Cdouble,
    )::Cchar
end

function GEOSDistanceIndexed_r(handle, g1, g2, dist)
    @timeitccall libgeos.GEOSDistanceIndexed_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        dist::Ptr{Cdouble},
    )::Cint
end

function GEOSHausdorffDistance_r(handle, g1, g2, dist)
    @timeitccall libgeos.GEOSHausdorffDistance_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        dist::Ptr{Cdouble},
    )::Cint
end

function GEOSHausdorffDistanceDensify_r(handle, g1, g2, densifyFrac, dist)
    @timeitccall libgeos.GEOSHausdorffDistanceDensify_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        densifyFrac::Cdouble,
        dist::Ptr{Cdouble},
    )::Cint
end

function GEOSFrechetDistance_r(handle, g1, g2, dist)
    @timeitccall libgeos.GEOSFrechetDistance_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        dist::Ptr{Cdouble},
    )::Cint
end

function GEOSFrechetDistanceDensify_r(handle, g1, g2, densifyFrac, dist)
    @timeitccall libgeos.GEOSFrechetDistanceDensify_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        densifyFrac::Cdouble,
        dist::Ptr{Cdouble},
    )::Cint
end

function GEOSHilbertCode_r(handle, geom, extent, level, code)
    @timeitccall libgeos.GEOSHilbertCode_r(
        handle::GEOSContextHandle_t,
        geom::Ptr{GEOSGeometry},
        extent::Ptr{GEOSGeometry},
        level::Cuint,
        code::Ptr{Cuint},
    )::Cint
end

function GEOSGeomGetLength_r(handle, g, length)
    @timeitccall libgeos.GEOSGeomGetLength_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        length::Ptr{Cdouble},
    )::Cint
end

function GEOSNearestPoints_r(handle, g1, g2)
    @timeitccall libgeos.GEOSNearestPoints_r(
        handle::GEOSContextHandle_t,
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Ptr{GEOSCoordSequence}
end

function GEOSGeom_transformXY_r(handle, g, callback, userdata)
    @timeitccall libgeos.GEOSGeom_transformXY_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        callback::GEOSTransformXYCallback,
        userdata::Ptr{Cvoid},
    )::Ptr{GEOSGeometry}
end

function GEOSOrientationIndex_r(handle, Ax, Ay, Bx, By, Px, Py)
    @timeitccall libgeos.GEOSOrientationIndex_r(
        handle::GEOSContextHandle_t,
        Ax::Cdouble,
        Ay::Cdouble,
        Bx::Cdouble,
        By::Cdouble,
        Px::Cdouble,
        Py::Cdouble,
    )::Cint
end

const GEOSWKTReader_t = Cvoid

const GEOSWKTReader = GEOSWKTReader_t

const GEOSWKTWriter_t = Cvoid

const GEOSWKTWriter = GEOSWKTWriter_t

const GEOSWKBReader_t = Cvoid

const GEOSWKBReader = GEOSWKBReader_t

const GEOSWKBWriter_t = Cvoid

const GEOSWKBWriter = GEOSWKBWriter_t

const GEOSGeoJSONReader_t = Cvoid

const GEOSGeoJSONReader = GEOSGeoJSONReader_t

const GEOSGeoJSONWriter_t = Cvoid

const GEOSGeoJSONWriter = GEOSGeoJSONWriter_t

function GEOSWKTReader_create_r(handle)
    @timeitccall libgeos.GEOSWKTReader_create_r(handle::GEOSContextHandle_t)::Ptr{GEOSWKTReader}
end

function GEOSWKTReader_destroy_r(handle, reader)
    @timeitccall libgeos.GEOSWKTReader_destroy_r(
        handle::GEOSContextHandle_t,
        reader::Ptr{GEOSWKTReader},
    )::Cvoid
end

function GEOSWKTReader_read_r(handle, reader, wkt)
    @timeitccall libgeos.GEOSWKTReader_read_r(
        handle::GEOSContextHandle_t,
        reader::Ptr{GEOSWKTReader},
        wkt::Cstring,
    )::Ptr{GEOSGeometry}
end

function GEOSWKTReader_setFixStructure_r(handle, reader, doFix)
    @timeitccall libgeos.GEOSWKTReader_setFixStructure_r(
        handle::GEOSContextHandle_t,
        reader::Ptr{GEOSWKTReader},
        doFix::Cchar,
    )::Cvoid
end

function GEOSWKTWriter_create_r(handle)
    @timeitccall libgeos.GEOSWKTWriter_create_r(handle::GEOSContextHandle_t)::Ptr{GEOSWKTWriter}
end

function GEOSWKTWriter_destroy_r(handle, writer)
    @timeitccall libgeos.GEOSWKTWriter_destroy_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKTWriter},
    )::Cvoid
end

function GEOSWKTWriter_write_r(handle, writer, g)
    string_copy_free(
        @timeitccall(
            libgeos.GEOSWKTWriter_write_r(
                handle::GEOSContextHandle_t,
                writer::Ptr{GEOSWKTWriter},
                g::Ptr{GEOSGeometry},
            )::Cstring
        ),
        handle,
    )
end

function GEOSWKTWriter_setTrim_r(handle, writer, trim)
    @timeitccall libgeos.GEOSWKTWriter_setTrim_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKTWriter},
        trim::Cchar,
    )::Cvoid
end

function GEOSWKTWriter_setRoundingPrecision_r(handle, writer, precision)
    @timeitccall libgeos.GEOSWKTWriter_setRoundingPrecision_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKTWriter},
        precision::Cint,
    )::Cvoid
end

function GEOSWKTWriter_setOutputDimension_r(handle, writer, dim)
    @timeitccall libgeos.GEOSWKTWriter_setOutputDimension_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKTWriter},
        dim::Cint,
    )::Cvoid
end

function GEOSWKTWriter_getOutputDimension_r(handle, writer)
    @timeitccall libgeos.GEOSWKTWriter_getOutputDimension_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKTWriter},
    )::Cint
end

function GEOSWKTWriter_setOld3D_r(handle, writer, useOld3D)
    @timeitccall libgeos.GEOSWKTWriter_setOld3D_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKTWriter},
        useOld3D::Cint,
    )::Cvoid
end

function GEOSWKBReader_create_r(handle)
    @timeitccall libgeos.GEOSWKBReader_create_r(handle::GEOSContextHandle_t)::Ptr{GEOSWKBReader}
end

function GEOSWKBReader_destroy_r(handle, reader)
    @timeitccall libgeos.GEOSWKBReader_destroy_r(
        handle::GEOSContextHandle_t,
        reader::Ptr{GEOSWKBReader},
    )::Cvoid
end

function GEOSWKBReader_setFixStructure_r(handle, reader, doFix)
    @timeitccall libgeos.GEOSWKBReader_setFixStructure_r(
        handle::GEOSContextHandle_t,
        reader::Ptr{GEOSWKBReader},
        doFix::Cchar,
    )::Cvoid
end

function GEOSWKBReader_read_r(handle, reader, wkb, size)
    @timeitccall libgeos.GEOSWKBReader_read_r(
        handle::GEOSContextHandle_t,
        reader::Ptr{GEOSWKBReader},
        wkb::Ptr{Cuchar},
        size::Csize_t,
    )::Ptr{GEOSGeometry}
end

function GEOSWKBReader_readHEX_r(handle, reader, hex, size)
    @timeitccall libgeos.GEOSWKBReader_readHEX_r(
        handle::GEOSContextHandle_t,
        reader::Ptr{GEOSWKBReader},
        hex::Ptr{Cuchar},
        size::Csize_t,
    )::Ptr{GEOSGeometry}
end

function GEOSWKBWriter_create_r(handle)
    @timeitccall libgeos.GEOSWKBWriter_create_r(handle::GEOSContextHandle_t)::Ptr{GEOSWKBWriter}
end

function GEOSWKBWriter_destroy_r(handle, writer)
    @timeitccall libgeos.GEOSWKBWriter_destroy_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKBWriter},
    )::Cvoid
end

function GEOSWKBWriter_write_r(handle, writer, g, size)
    @timeitccall libgeos.GEOSWKBWriter_write_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKBWriter},
        g::Ptr{GEOSGeometry},
        size::Ptr{Csize_t},
    )::Ptr{Cuchar}
end

function GEOSWKBWriter_writeHEX_r(handle, writer, g, size)
    @timeitccall libgeos.GEOSWKBWriter_writeHEX_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKBWriter},
        g::Ptr{GEOSGeometry},
        size::Ptr{Csize_t},
    )::Ptr{Cuchar}
end

function GEOSWKBWriter_getOutputDimension_r(handle, writer)
    @timeitccall libgeos.GEOSWKBWriter_getOutputDimension_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKBWriter},
    )::Cint
end

function GEOSWKBWriter_setOutputDimension_r(handle, writer, newDimension)
    @timeitccall libgeos.GEOSWKBWriter_setOutputDimension_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKBWriter},
        newDimension::Cint,
    )::Cvoid
end

function GEOSWKBWriter_getByteOrder_r(handle, writer)
    @timeitccall libgeos.GEOSWKBWriter_getByteOrder_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKBWriter},
    )::Cint
end

function GEOSWKBWriter_setByteOrder_r(handle, writer, byteOrder)
    @timeitccall libgeos.GEOSWKBWriter_setByteOrder_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKBWriter},
        byteOrder::Cint,
    )::Cvoid
end

function GEOSWKBWriter_getFlavor_r(handle, writer)
    @timeitccall libgeos.GEOSWKBWriter_getFlavor_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKBWriter},
    )::Cint
end

function GEOSWKBWriter_setFlavor_r(handle, writer, flavor)
    @timeitccall libgeos.GEOSWKBWriter_setFlavor_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKBWriter},
        flavor::Cint,
    )::Cvoid
end

function GEOSWKBWriter_getIncludeSRID_r(handle, writer)
    @timeitccall libgeos.GEOSWKBWriter_getIncludeSRID_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKBWriter},
    )::Cchar
end

function GEOSWKBWriter_setIncludeSRID_r(handle, writer, writeSRID)
    @timeitccall libgeos.GEOSWKBWriter_setIncludeSRID_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSWKBWriter},
        writeSRID::Cchar,
    )::Cvoid
end

function GEOSGeoJSONReader_create_r(handle)
    @timeitccall libgeos.GEOSGeoJSONReader_create_r(
        handle::GEOSContextHandle_t,
    )::Ptr{GEOSGeoJSONReader}
end

function GEOSGeoJSONReader_destroy_r(handle, reader)
    @timeitccall libgeos.GEOSGeoJSONReader_destroy_r(
        handle::GEOSContextHandle_t,
        reader::Ptr{GEOSGeoJSONReader},
    )::Cvoid
end

function GEOSGeoJSONReader_readGeometry_r(handle, reader, geojson)
    @timeitccall libgeos.GEOSGeoJSONReader_readGeometry_r(
        handle::GEOSContextHandle_t,
        reader::Ptr{GEOSGeoJSONReader},
        geojson::Cstring,
    )::Ptr{GEOSGeometry}
end

function GEOSGeoJSONWriter_create_r(handle)
    @timeitccall libgeos.GEOSGeoJSONWriter_create_r(
        handle::GEOSContextHandle_t,
    )::Ptr{GEOSGeoJSONWriter}
end

function GEOSGeoJSONWriter_destroy_r(handle, writer)
    @timeitccall libgeos.GEOSGeoJSONWriter_destroy_r(
        handle::GEOSContextHandle_t,
        writer::Ptr{GEOSGeoJSONWriter},
    )::Cvoid
end

function GEOSGeoJSONWriter_writeGeometry_r(handle, writer, g, indent)
    string_copy_free(
        @timeitccall(
            libgeos.GEOSGeoJSONWriter_writeGeometry_r(
                handle::GEOSContextHandle_t,
                writer::Ptr{GEOSGeoJSONWriter},
                g::Ptr{GEOSGeometry},
                indent::Cint,
            )::Cstring
        ),
        handle,
    )
end

function GEOSFree_r(handle, buffer)
    @timeitccall libgeos.GEOSFree_r(handle::GEOSContextHandle_t, buffer::Ptr{Cvoid})::Cvoid
end

function GEOSversion()
    unsafe_string(@timeitccall(libgeos.GEOSversion()::Cstring))
end

function initGEOS(notice_function, error_function)
    @timeitccall libgeos.initGEOS(
        notice_function::GEOSMessageHandler,
        error_function::GEOSMessageHandler,
    )::Cvoid
end

function finishGEOS()
    @timeitccall libgeos.finishGEOS()::Cvoid
end

function GEOSFree(buffer)
    @timeitccall libgeos.GEOSFree(buffer::Ptr{Cvoid})::Cvoid
end

function GEOSCoordSeq_create(size, dims)
    @timeitccall libgeos.GEOSCoordSeq_create(size::Cuint, dims::Cuint)::Ptr{GEOSCoordSequence}
end

function GEOSCoordSeq_copyFromBuffer(buf, size, hasZ, hasM)
    @timeitccall libgeos.GEOSCoordSeq_copyFromBuffer(
        buf::Ptr{Cdouble},
        size::Cuint,
        hasZ::Cint,
        hasM::Cint,
    )::Ptr{GEOSCoordSequence}
end

function GEOSCoordSeq_copyFromArrays(x, y, z, m, size)
    @timeitccall libgeos.GEOSCoordSeq_copyFromArrays(
        x::Ptr{Cdouble},
        y::Ptr{Cdouble},
        z::Ptr{Cdouble},
        m::Ptr{Cdouble},
        size::Cuint,
    )::Ptr{GEOSCoordSequence}
end

function GEOSCoordSeq_copyToBuffer(s, buf, hasZ, hasM)
    @timeitccall libgeos.GEOSCoordSeq_copyToBuffer(
        s::Ptr{GEOSCoordSequence},
        buf::Ptr{Cdouble},
        hasZ::Cint,
        hasM::Cint,
    )::Cint
end

function GEOSCoordSeq_copyToArrays(s, x, y, z, m)
    @timeitccall libgeos.GEOSCoordSeq_copyToArrays(
        s::Ptr{GEOSCoordSequence},
        x::Ptr{Cdouble},
        y::Ptr{Cdouble},
        z::Ptr{Cdouble},
        m::Ptr{Cdouble},
    )::Cint
end

function GEOSCoordSeq_clone(s)
    @timeitccall libgeos.GEOSCoordSeq_clone(s::Ptr{GEOSCoordSequence})::Ptr{GEOSCoordSequence}
end

function GEOSCoordSeq_destroy(s)
    @timeitccall libgeos.GEOSCoordSeq_destroy(s::Ptr{GEOSCoordSequence})::Cvoid
end

function GEOSCoordSeq_setX(s, idx, val)
    @timeitccall libgeos.GEOSCoordSeq_setX(
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        val::Cdouble,
    )::Cint
end

function GEOSCoordSeq_setY(s, idx, val)
    @timeitccall libgeos.GEOSCoordSeq_setY(
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        val::Cdouble,
    )::Cint
end

function GEOSCoordSeq_setZ(s, idx, val)
    @timeitccall libgeos.GEOSCoordSeq_setZ(
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        val::Cdouble,
    )::Cint
end

function GEOSCoordSeq_setXY(s, idx, x, y)
    @timeitccall libgeos.GEOSCoordSeq_setXY(
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        x::Cdouble,
        y::Cdouble,
    )::Cint
end

function GEOSCoordSeq_setXYZ(s, idx, x, y, z)
    @timeitccall libgeos.GEOSCoordSeq_setXYZ(
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        x::Cdouble,
        y::Cdouble,
        z::Cdouble,
    )::Cint
end

function GEOSCoordSeq_setOrdinate(s, idx, dim, val)
    @timeitccall libgeos.GEOSCoordSeq_setOrdinate(
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        dim::Cuint,
        val::Cdouble,
    )::Cint
end

function GEOSCoordSeq_getX(s, idx, val)
    @timeitccall libgeos.GEOSCoordSeq_getX(
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        val::Ptr{Cdouble},
    )::Cint
end

function GEOSCoordSeq_getY(s, idx, val)
    @timeitccall libgeos.GEOSCoordSeq_getY(
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        val::Ptr{Cdouble},
    )::Cint
end

function GEOSCoordSeq_getZ(s, idx, val)
    @timeitccall libgeos.GEOSCoordSeq_getZ(
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        val::Ptr{Cdouble},
    )::Cint
end

function GEOSCoordSeq_getXY(s, idx, x, y)
    @timeitccall libgeos.GEOSCoordSeq_getXY(
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        x::Ptr{Cdouble},
        y::Ptr{Cdouble},
    )::Cint
end

function GEOSCoordSeq_getXYZ(s, idx, x, y, z)
    @timeitccall libgeos.GEOSCoordSeq_getXYZ(
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        x::Ptr{Cdouble},
        y::Ptr{Cdouble},
        z::Ptr{Cdouble},
    )::Cint
end

function GEOSCoordSeq_getOrdinate(s, idx, dim, val)
    @timeitccall libgeos.GEOSCoordSeq_getOrdinate(
        s::Ptr{GEOSCoordSequence},
        idx::Cuint,
        dim::Cuint,
        val::Ptr{Cdouble},
    )::Cint
end

function GEOSCoordSeq_getSize(s, size)
    @timeitccall libgeos.GEOSCoordSeq_getSize(s::Ptr{GEOSCoordSequence}, size::Ptr{Cuint})::Cint
end

function GEOSCoordSeq_getDimensions(s, dims)
    @timeitccall libgeos.GEOSCoordSeq_getDimensions(
        s::Ptr{GEOSCoordSequence},
        dims::Ptr{Cuint},
    )::Cint
end

function GEOSCoordSeq_isCCW(s, is_ccw)
    @timeitccall libgeos.GEOSCoordSeq_isCCW(s::Ptr{GEOSCoordSequence}, is_ccw::Cstring)::Cint
end

function GEOSGeom_createPoint(s)
    @timeitccall libgeos.GEOSGeom_createPoint(s::Ptr{GEOSCoordSequence})::Ptr{GEOSGeometry}
end

function GEOSGeom_createPointFromXY(x, y)
    @timeitccall libgeos.GEOSGeom_createPointFromXY(x::Cdouble, y::Cdouble)::Ptr{GEOSGeometry}
end

function GEOSGeom_createEmptyPoint()
    @timeitccall libgeos.GEOSGeom_createEmptyPoint()::Ptr{GEOSGeometry}
end

function GEOSGeom_createLinearRing(s)
    @timeitccall libgeos.GEOSGeom_createLinearRing(s::Ptr{GEOSCoordSequence})::Ptr{GEOSGeometry}
end

function GEOSGeom_createLineString(s)
    @timeitccall libgeos.GEOSGeom_createLineString(s::Ptr{GEOSCoordSequence})::Ptr{GEOSGeometry}
end

function GEOSGeom_createEmptyLineString()
    @timeitccall libgeos.GEOSGeom_createEmptyLineString()::Ptr{GEOSGeometry}
end

function GEOSGeom_createEmptyPolygon()
    @timeitccall libgeos.GEOSGeom_createEmptyPolygon()::Ptr{GEOSGeometry}
end

function GEOSGeom_createPolygon(shell, holes, nholes)
    @timeitccall libgeos.GEOSGeom_createPolygon(
        shell::Ptr{GEOSGeometry},
        holes::Ptr{Ptr{GEOSGeometry}},
        nholes::Cuint,
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_createCollection(type, geoms, ngeoms)
    @timeitccall libgeos.GEOSGeom_createCollection(
        type::Cint,
        geoms::Ptr{Ptr{GEOSGeometry}},
        ngeoms::Cuint,
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_createEmptyCollection(type)
    @timeitccall libgeos.GEOSGeom_createEmptyCollection(type::Cint)::Ptr{GEOSGeometry}
end

function GEOSGeom_createRectangle(xmin, ymin, xmax, ymax)
    @timeitccall libgeos.GEOSGeom_createRectangle(
        xmin::Cdouble,
        ymin::Cdouble,
        xmax::Cdouble,
        ymax::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_clone(g)
    @timeitccall libgeos.GEOSGeom_clone(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSGeom_destroy(g)
    @timeitccall libgeos.GEOSGeom_destroy(g::Ptr{GEOSGeometry})::Cvoid
end

function GEOSGeomType(g)
    string_copy_free(@timeitccall(libgeos.GEOSGeomType(g::Ptr{GEOSGeometry})::Cstring))
end

function GEOSGeomTypeId(g)
    @timeitccall libgeos.GEOSGeomTypeId(g::Ptr{GEOSGeometry})::Cint
end

function GEOSGetSRID(g)
    @timeitccall libgeos.GEOSGetSRID(g::Ptr{GEOSGeometry})::Cint
end

function GEOSGeom_getUserData(g)
    @timeitccall libgeos.GEOSGeom_getUserData(g::Ptr{GEOSGeometry})::Ptr{Cvoid}
end

function GEOSGetNumGeometries(g)
    @timeitccall libgeos.GEOSGetNumGeometries(g::Ptr{GEOSGeometry})::Cint
end

function GEOSGetGeometryN(g, n)
    @timeitccall libgeos.GEOSGetGeometryN(g::Ptr{GEOSGeometry}, n::Cint)::Ptr{GEOSGeometry}
end

function GEOSGeom_getPrecision(g)
    @timeitccall libgeos.GEOSGeom_getPrecision(g::Ptr{GEOSGeometry})::Cdouble
end

function GEOSGetNumInteriorRings(g)
    @timeitccall libgeos.GEOSGetNumInteriorRings(g::Ptr{GEOSGeometry})::Cint
end

function GEOSGeomGetNumPoints(g)
    @timeitccall libgeos.GEOSGeomGetNumPoints(g::Ptr{GEOSGeometry})::Cint
end

function GEOSGeomGetX(g, x)
    @timeitccall libgeos.GEOSGeomGetX(g::Ptr{GEOSGeometry}, x::Ptr{Cdouble})::Cint
end

function GEOSGeomGetY(g, y)
    @timeitccall libgeos.GEOSGeomGetY(g::Ptr{GEOSGeometry}, y::Ptr{Cdouble})::Cint
end

function GEOSGeomGetZ(g, z)
    @timeitccall libgeos.GEOSGeomGetZ(g::Ptr{GEOSGeometry}, z::Ptr{Cdouble})::Cint
end

function GEOSGetInteriorRingN(g, n)
    @timeitccall libgeos.GEOSGetInteriorRingN(g::Ptr{GEOSGeometry}, n::Cint)::Ptr{GEOSGeometry}
end

function GEOSGetExteriorRing(g)
    @timeitccall libgeos.GEOSGetExteriorRing(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSGetNumCoordinates(g)
    @timeitccall libgeos.GEOSGetNumCoordinates(g::Ptr{GEOSGeometry})::Cint
end

function GEOSGeom_getCoordSeq(g)
    @timeitccall libgeos.GEOSGeom_getCoordSeq(g::Ptr{GEOSGeometry})::Ptr{GEOSCoordSequence}
end

function GEOSGeom_getDimensions(g)
    @timeitccall libgeos.GEOSGeom_getDimensions(g::Ptr{GEOSGeometry})::Cint
end

function GEOSGeom_getCoordinateDimension(g)
    @timeitccall libgeos.GEOSGeom_getCoordinateDimension(g::Ptr{GEOSGeometry})::Cint
end

function GEOSGeom_getXMin(g, value)
    @timeitccall libgeos.GEOSGeom_getXMin(g::Ptr{GEOSGeometry}, value::Ptr{Cdouble})::Cint
end

function GEOSGeom_getYMin(g, value)
    @timeitccall libgeos.GEOSGeom_getYMin(g::Ptr{GEOSGeometry}, value::Ptr{Cdouble})::Cint
end

function GEOSGeom_getXMax(g, value)
    @timeitccall libgeos.GEOSGeom_getXMax(g::Ptr{GEOSGeometry}, value::Ptr{Cdouble})::Cint
end

function GEOSGeom_getYMax(g, value)
    @timeitccall libgeos.GEOSGeom_getYMax(g::Ptr{GEOSGeometry}, value::Ptr{Cdouble})::Cint
end

function GEOSGeom_getExtent(g, xmin, ymin, xmax, ymax)
    @timeitccall libgeos.GEOSGeom_getExtent(
        g::Ptr{GEOSGeometry},
        xmin::Ptr{Cdouble},
        ymin::Ptr{Cdouble},
        xmax::Ptr{Cdouble},
        ymax::Ptr{Cdouble},
    )::Cint
end

function GEOSGeomGetPointN(g, n)
    @timeitccall libgeos.GEOSGeomGetPointN(g::Ptr{GEOSGeometry}, n::Cint)::Ptr{GEOSGeometry}
end

function GEOSGeomGetStartPoint(g)
    @timeitccall libgeos.GEOSGeomGetStartPoint(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSGeomGetEndPoint(g)
    @timeitccall libgeos.GEOSGeomGetEndPoint(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSisEmpty(g)
    @timeitccall libgeos.GEOSisEmpty(g::Ptr{GEOSGeometry})::Cchar
end

function GEOSisRing(g)
    @timeitccall libgeos.GEOSisRing(g::Ptr{GEOSGeometry})::Cchar
end

function GEOSHasZ(g)
    @timeitccall libgeos.GEOSHasZ(g::Ptr{GEOSGeometry})::Cchar
end

function GEOSisClosed(g)
    @timeitccall libgeos.GEOSisClosed(g::Ptr{GEOSGeometry})::Cchar
end

function GEOSSetSRID(g, SRID)
    @timeitccall libgeos.GEOSSetSRID(g::Ptr{GEOSGeometry}, SRID::Cint)::Cvoid
end

function GEOSGeom_setUserData(g, userData)
    @timeitccall libgeos.GEOSGeom_setUserData(g::Ptr{GEOSGeometry}, userData::Ptr{Cvoid})::Cvoid
end

function GEOSNormalize(g)
    @timeitccall libgeos.GEOSNormalize(g::Ptr{GEOSGeometry})::Cint
end

function GEOSisSimple(g)
    @timeitccall libgeos.GEOSisSimple(g::Ptr{GEOSGeometry})::Cchar
end

function GEOSisValid(g)
    @timeitccall libgeos.GEOSisValid(g::Ptr{GEOSGeometry})::Cchar
end

function GEOSisValidReason(g)
    string_copy_free(@timeitccall(libgeos.GEOSisValidReason(g::Ptr{GEOSGeometry})::Cstring))
end

function GEOSisValidDetail(g, flags, reason, location)
    @timeitccall libgeos.GEOSisValidDetail(
        g::Ptr{GEOSGeometry},
        flags::Cint,
        reason::Ptr{Cstring},
        location::Ptr{Ptr{GEOSGeometry}},
    )::Cchar
end

function GEOSMakeValid(g)
    @timeitccall libgeos.GEOSMakeValid(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSMakeValidWithParams(g, makeValidParams)
    @timeitccall libgeos.GEOSMakeValidWithParams(
        g::Ptr{GEOSGeometry},
        makeValidParams::Ptr{GEOSMakeValidParams},
    )::Ptr{GEOSGeometry}
end

function GEOSMakeValidParams_create()
    @timeitccall libgeos.GEOSMakeValidParams_create()::Ptr{GEOSMakeValidParams}
end

function GEOSMakeValidParams_destroy(parms)
    @timeitccall libgeos.GEOSMakeValidParams_destroy(parms::Ptr{GEOSMakeValidParams})::Cvoid
end

function GEOSMakeValidParams_setMethod(p, method)
    @timeitccall libgeos.GEOSMakeValidParams_setMethod(
        p::Ptr{GEOSMakeValidParams},
        method::GEOSMakeValidMethods,
    )::Cint
end

function GEOSMakeValidParams_setKeepCollapsed(p, keepCollapsed)
    @timeitccall libgeos.GEOSMakeValidParams_setKeepCollapsed(
        p::Ptr{GEOSMakeValidParams},
        keepCollapsed::Cint,
    )::Cint
end

function GEOSMinimumClearance(g, d)
    @timeitccall libgeos.GEOSMinimumClearance(g::Ptr{GEOSGeometry}, d::Ptr{Cdouble})::Cint
end

function GEOSMinimumClearanceLine(g)
    @timeitccall libgeos.GEOSMinimumClearanceLine(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSRemoveRepeatedPoints(g, tolerance)
    @timeitccall libgeos.GEOSRemoveRepeatedPoints(
        g::Ptr{GEOSGeometry},
        tolerance::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSArea(g, area)
    @timeitccall libgeos.GEOSArea(g::Ptr{GEOSGeometry}, area::Ptr{Cdouble})::Cint
end

function GEOSLength(g, length)
    @timeitccall libgeos.GEOSLength(g::Ptr{GEOSGeometry}, length::Ptr{Cdouble})::Cint
end

function GEOSGeomGetLength(g, length)
    @timeitccall libgeos.GEOSGeomGetLength(g::Ptr{GEOSGeometry}, length::Ptr{Cdouble})::Cint
end

function GEOSDistance(g1, g2, dist)
    @timeitccall libgeos.GEOSDistance(
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        dist::Ptr{Cdouble},
    )::Cint
end

function GEOSDistanceWithin(g1, g2, dist)
    @timeitccall libgeos.GEOSDistanceWithin(
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        dist::Cdouble,
    )::Cchar
end

function GEOSDistanceIndexed(g1, g2, dist)
    @timeitccall libgeos.GEOSDistanceIndexed(
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        dist::Ptr{Cdouble},
    )::Cint
end

function GEOSNearestPoints(g1, g2)
    @timeitccall libgeos.GEOSNearestPoints(
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Ptr{GEOSCoordSequence}
end

function GEOSHausdorffDistance(g1, g2, dist)
    @timeitccall libgeos.GEOSHausdorffDistance(
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        dist::Ptr{Cdouble},
    )::Cint
end

function GEOSHausdorffDistanceDensify(g1, g2, densifyFrac, dist)
    @timeitccall libgeos.GEOSHausdorffDistanceDensify(
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        densifyFrac::Cdouble,
        dist::Ptr{Cdouble},
    )::Cint
end

function GEOSFrechetDistance(g1, g2, dist)
    @timeitccall libgeos.GEOSFrechetDistance(
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        dist::Ptr{Cdouble},
    )::Cint
end

function GEOSFrechetDistanceDensify(g1, g2, densifyFrac, dist)
    @timeitccall libgeos.GEOSFrechetDistanceDensify(
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        densifyFrac::Cdouble,
        dist::Ptr{Cdouble},
    )::Cint
end

function GEOSProject(line, point)
    @timeitccall libgeos.GEOSProject(line::Ptr{GEOSGeometry}, point::Ptr{GEOSGeometry})::Cdouble
end

function GEOSInterpolate(line, d)
    @timeitccall libgeos.GEOSInterpolate(line::Ptr{GEOSGeometry}, d::Cdouble)::Ptr{GEOSGeometry}
end

function GEOSProjectNormalized(line, point)
    @timeitccall libgeos.GEOSProjectNormalized(
        line::Ptr{GEOSGeometry},
        point::Ptr{GEOSGeometry},
    )::Cdouble
end

function GEOSInterpolateNormalized(line, proportion)
    @timeitccall libgeos.GEOSInterpolateNormalized(
        line::Ptr{GEOSGeometry},
        proportion::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSIntersection(g1, g2)
    @timeitccall libgeos.GEOSIntersection(
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSIntersectionPrec(g1, g2, gridSize)
    @timeitccall libgeos.GEOSIntersectionPrec(
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        gridSize::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSDifference(ga, gb)
    @timeitccall libgeos.GEOSDifference(
        ga::Ptr{GEOSGeometry},
        gb::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSDifferencePrec(ga, gb, gridSize)
    @timeitccall libgeos.GEOSDifferencePrec(
        ga::Ptr{GEOSGeometry},
        gb::Ptr{GEOSGeometry},
        gridSize::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSSymDifference(ga, gb)
    @timeitccall libgeos.GEOSSymDifference(
        ga::Ptr{GEOSGeometry},
        gb::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSSymDifferencePrec(ga, gb, gridSize)
    @timeitccall libgeos.GEOSSymDifferencePrec(
        ga::Ptr{GEOSGeometry},
        gb::Ptr{GEOSGeometry},
        gridSize::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSUnion(ga, gb)
    @timeitccall libgeos.GEOSUnion(
        ga::Ptr{GEOSGeometry},
        gb::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSUnionPrec(ga, gb, gridSize)
    @timeitccall libgeos.GEOSUnionPrec(
        ga::Ptr{GEOSGeometry},
        gb::Ptr{GEOSGeometry},
        gridSize::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSUnaryUnion(g)
    @timeitccall libgeos.GEOSUnaryUnion(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSUnaryUnionPrec(g, gridSize)
    @timeitccall libgeos.GEOSUnaryUnionPrec(
        g::Ptr{GEOSGeometry},
        gridSize::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSCoverageUnion(g)
    @timeitccall libgeos.GEOSCoverageUnion(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSClipByRect(g, xmin, ymin, xmax, ymax)
    @timeitccall libgeos.GEOSClipByRect(
        g::Ptr{GEOSGeometry},
        xmin::Cdouble,
        ymin::Cdouble,
        xmax::Cdouble,
        ymax::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSSharedPaths(g1, g2)
    @timeitccall libgeos.GEOSSharedPaths(
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSBuffer(g, width, quadsegs)
    @timeitccall libgeos.GEOSBuffer(
        g::Ptr{GEOSGeometry},
        width::Cdouble,
        quadsegs::Cint,
    )::Ptr{GEOSGeometry}
end

function GEOSBufferParams_create()
    @timeitccall libgeos.GEOSBufferParams_create()::Ptr{GEOSBufferParams}
end

function GEOSBufferParams_destroy(parms)
    @timeitccall libgeos.GEOSBufferParams_destroy(parms::Ptr{GEOSBufferParams})::Cvoid
end

function GEOSBufferParams_setEndCapStyle(p, style)
    @timeitccall libgeos.GEOSBufferParams_setEndCapStyle(
        p::Ptr{GEOSBufferParams},
        style::Cint,
    )::Cint
end

function GEOSBufferParams_setJoinStyle(p, joinStyle)
    @timeitccall libgeos.GEOSBufferParams_setJoinStyle(
        p::Ptr{GEOSBufferParams},
        joinStyle::Cint,
    )::Cint
end

function GEOSBufferParams_setMitreLimit(p, mitreLimit)
    @timeitccall libgeos.GEOSBufferParams_setMitreLimit(
        p::Ptr{GEOSBufferParams},
        mitreLimit::Cdouble,
    )::Cint
end

function GEOSBufferParams_setQuadrantSegments(p, quadSegs)
    @timeitccall libgeos.GEOSBufferParams_setQuadrantSegments(
        p::Ptr{GEOSBufferParams},
        quadSegs::Cint,
    )::Cint
end

function GEOSBufferParams_setSingleSided(p, singleSided)
    @timeitccall libgeos.GEOSBufferParams_setSingleSided(
        p::Ptr{GEOSBufferParams},
        singleSided::Cint,
    )::Cint
end

function GEOSBufferWithParams(g, p, width)
    @timeitccall libgeos.GEOSBufferWithParams(
        g::Ptr{GEOSGeometry},
        p::Ptr{GEOSBufferParams},
        width::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSBufferWithStyle(g, width, quadsegs, endCapStyle, joinStyle, mitreLimit)
    @timeitccall libgeos.GEOSBufferWithStyle(
        g::Ptr{GEOSGeometry},
        width::Cdouble,
        quadsegs::Cint,
        endCapStyle::Cint,
        joinStyle::Cint,
        mitreLimit::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSOffsetCurve(g, width, quadsegs, joinStyle, mitreLimit)
    @timeitccall libgeos.GEOSOffsetCurve(
        g::Ptr{GEOSGeometry},
        width::Cdouble,
        quadsegs::Cint,
        joinStyle::Cint,
        mitreLimit::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSEnvelope(g)
    @timeitccall libgeos.GEOSEnvelope(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSBoundary(g)
    @timeitccall libgeos.GEOSBoundary(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSConvexHull(g)
    @timeitccall libgeos.GEOSConvexHull(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSConcaveHull(g, ratio, allowHoles)
    @timeitccall libgeos.GEOSConcaveHull(
        g::Ptr{GEOSGeometry},
        ratio::Cdouble,
        allowHoles::Cuint,
    )::Ptr{GEOSGeometry}
end

function GEOSPolygonHullSimplify(g, isOuter, vertexNumFraction)
    @timeitccall libgeos.GEOSPolygonHullSimplify(
        g::Ptr{GEOSGeometry},
        isOuter::Cuint,
        vertexNumFraction::Cdouble,
    )::Ptr{GEOSGeometry}
end

@cenum GEOSPolygonHullParameterModes::UInt32 begin
    GEOSHULL_PARAM_VERTEX_RATIO = 1
    GEOSHULL_PARAM_AREA_RATIO = 2
end

function GEOSPolygonHullSimplifyMode(g, isOuter, parameterMode, parameter)
    @timeitccall libgeos.GEOSPolygonHullSimplifyMode(
        g::Ptr{GEOSGeometry},
        isOuter::Cuint,
        parameterMode::Cuint,
        parameter::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSConcaveHullOfPolygons(g, lengthRatio, isTight, isHolesAllowed)
    @timeitccall libgeos.GEOSConcaveHullOfPolygons(
        g::Ptr{GEOSGeometry},
        lengthRatio::Cdouble,
        isTight::Cuint,
        isHolesAllowed::Cuint,
    )::Ptr{GEOSGeometry}
end

function GEOSMinimumRotatedRectangle(g)
    @timeitccall libgeos.GEOSMinimumRotatedRectangle(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSMaximumInscribedCircle(g, tolerance)
    @timeitccall libgeos.GEOSMaximumInscribedCircle(
        g::Ptr{GEOSGeometry},
        tolerance::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSLargestEmptyCircle(obstacles, boundary, tolerance)
    @timeitccall libgeos.GEOSLargestEmptyCircle(
        obstacles::Ptr{GEOSGeometry},
        boundary::Ptr{GEOSGeometry},
        tolerance::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSMinimumWidth(g)
    @timeitccall libgeos.GEOSMinimumWidth(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSPointOnSurface(g)
    @timeitccall libgeos.GEOSPointOnSurface(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSGetCentroid(g)
    @timeitccall libgeos.GEOSGetCentroid(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSMinimumBoundingCircle(g, radius, center)
    @timeitccall libgeos.GEOSMinimumBoundingCircle(
        g::Ptr{GEOSGeometry},
        radius::Ptr{Cdouble},
        center::Ptr{Ptr{GEOSGeometry}},
    )::Ptr{GEOSGeometry}
end

function GEOSDelaunayTriangulation(g, tolerance, onlyEdges)
    @timeitccall libgeos.GEOSDelaunayTriangulation(
        g::Ptr{GEOSGeometry},
        tolerance::Cdouble,
        onlyEdges::Cint,
    )::Ptr{GEOSGeometry}
end

function GEOSConstrainedDelaunayTriangulation(g)
    @timeitccall libgeos.GEOSConstrainedDelaunayTriangulation(
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSVoronoiDiagram(g, env, tolerance, onlyEdges)
    @timeitccall libgeos.GEOSVoronoiDiagram(
        g::Ptr{GEOSGeometry},
        env::Ptr{GEOSGeometry},
        tolerance::Cdouble,
        onlyEdges::Cint,
    )::Ptr{GEOSGeometry}
end

function GEOSNode(g)
    @timeitccall libgeos.GEOSNode(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSPolygonize(geoms, ngeoms)
    @timeitccall libgeos.GEOSPolygonize(
        geoms::Ptr{Ptr{GEOSGeometry}},
        ngeoms::Cuint,
    )::Ptr{GEOSGeometry}
end

function GEOSPolygonize_valid(geoms, ngeoms)
    @timeitccall libgeos.GEOSPolygonize_valid(
        geoms::Ptr{Ptr{GEOSGeometry}},
        ngeoms::Cuint,
    )::Ptr{GEOSGeometry}
end

function GEOSPolygonizer_getCutEdges(geoms, ngeoms)
    @timeitccall libgeos.GEOSPolygonizer_getCutEdges(
        geoms::Ptr{Ptr{GEOSGeometry}},
        ngeoms::Cuint,
    )::Ptr{GEOSGeometry}
end

function GEOSPolygonize_full(input, cuts, dangles, invalid)
    @timeitccall libgeos.GEOSPolygonize_full(
        input::Ptr{GEOSGeometry},
        cuts::Ptr{Ptr{GEOSGeometry}},
        dangles::Ptr{Ptr{GEOSGeometry}},
        invalid::Ptr{Ptr{GEOSGeometry}},
    )::Ptr{GEOSGeometry}
end

function GEOSBuildArea(g)
    @timeitccall libgeos.GEOSBuildArea(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSDensify(g, tolerance)
    @timeitccall libgeos.GEOSDensify(g::Ptr{GEOSGeometry}, tolerance::Cdouble)::Ptr{GEOSGeometry}
end

function GEOSLineMerge(g)
    @timeitccall libgeos.GEOSLineMerge(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSLineMergeDirected(g)
    @timeitccall libgeos.GEOSLineMergeDirected(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSReverse(g)
    @timeitccall libgeos.GEOSReverse(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSSimplify(g, tolerance)
    @timeitccall libgeos.GEOSSimplify(g::Ptr{GEOSGeometry}, tolerance::Cdouble)::Ptr{GEOSGeometry}
end

function GEOSTopologyPreserveSimplify(g, tolerance)
    @timeitccall libgeos.GEOSTopologyPreserveSimplify(
        g::Ptr{GEOSGeometry},
        tolerance::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_extractUniquePoints(g)
    @timeitccall libgeos.GEOSGeom_extractUniquePoints(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSHilbertCode(geom, extent, level, code)
    @timeitccall libgeos.GEOSHilbertCode(
        geom::Ptr{GEOSGeometry},
        extent::Ptr{GEOSGeometry},
        level::Cuint,
        code::Ptr{Cuint},
    )::Cint
end

function GEOSGeom_transformXY(g, callback, userdata)
    @timeitccall libgeos.GEOSGeom_transformXY(
        g::Ptr{GEOSGeometry},
        callback::GEOSTransformXYCallback,
        userdata::Ptr{Cvoid},
    )::Ptr{GEOSGeometry}
end

function GEOSSnap(input, snap_target, tolerance)
    @timeitccall libgeos.GEOSSnap(
        input::Ptr{GEOSGeometry},
        snap_target::Ptr{GEOSGeometry},
        tolerance::Cdouble,
    )::Ptr{GEOSGeometry}
end

function GEOSGeom_setPrecision(g, gridSize, flags)
    @timeitccall libgeos.GEOSGeom_setPrecision(
        g::Ptr{GEOSGeometry},
        gridSize::Cdouble,
        flags::Cint,
    )::Ptr{GEOSGeometry}
end

function GEOSDisjoint(g1, g2)
    @timeitccall libgeos.GEOSDisjoint(g1::Ptr{GEOSGeometry}, g2::Ptr{GEOSGeometry})::Cchar
end

function GEOSTouches(g1, g2)
    @timeitccall libgeos.GEOSTouches(g1::Ptr{GEOSGeometry}, g2::Ptr{GEOSGeometry})::Cchar
end

function GEOSIntersects(g1, g2)
    @timeitccall libgeos.GEOSIntersects(g1::Ptr{GEOSGeometry}, g2::Ptr{GEOSGeometry})::Cchar
end

function GEOSCrosses(g1, g2)
    @timeitccall libgeos.GEOSCrosses(g1::Ptr{GEOSGeometry}, g2::Ptr{GEOSGeometry})::Cchar
end

function GEOSWithin(g1, g2)
    @timeitccall libgeos.GEOSWithin(g1::Ptr{GEOSGeometry}, g2::Ptr{GEOSGeometry})::Cchar
end

function GEOSContains(g1, g2)
    @timeitccall libgeos.GEOSContains(g1::Ptr{GEOSGeometry}, g2::Ptr{GEOSGeometry})::Cchar
end

function GEOSOverlaps(g1, g2)
    @timeitccall libgeos.GEOSOverlaps(g1::Ptr{GEOSGeometry}, g2::Ptr{GEOSGeometry})::Cchar
end

function GEOSEquals(g1, g2)
    @timeitccall libgeos.GEOSEquals(g1::Ptr{GEOSGeometry}, g2::Ptr{GEOSGeometry})::Cchar
end

function GEOSCovers(g1, g2)
    @timeitccall libgeos.GEOSCovers(g1::Ptr{GEOSGeometry}, g2::Ptr{GEOSGeometry})::Cchar
end

function GEOSCoveredBy(g1, g2)
    @timeitccall libgeos.GEOSCoveredBy(g1::Ptr{GEOSGeometry}, g2::Ptr{GEOSGeometry})::Cchar
end

function GEOSEqualsExact(g1, g2, tolerance)
    @timeitccall libgeos.GEOSEqualsExact(
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        tolerance::Cdouble,
    )::Cchar
end

function GEOSRelatePattern(g1, g2, pat)
    @timeitccall libgeos.GEOSRelatePattern(
        g1::Ptr{GEOSGeometry},
        g2::Ptr{GEOSGeometry},
        pat::Cstring,
    )::Cchar
end

function GEOSRelate(g1, g2)
    string_copy_free(
        @timeitccall(libgeos.GEOSRelate(g1::Ptr{GEOSGeometry}, g2::Ptr{GEOSGeometry})::Cstring)
    )
end

function GEOSRelatePatternMatch(mat, pat)
    @timeitccall libgeos.GEOSRelatePatternMatch(mat::Cstring, pat::Cstring)::Cchar
end

function GEOSRelateBoundaryNodeRule(g1, g2, bnr)
    string_copy_free(
        @timeitccall(
            libgeos.GEOSRelateBoundaryNodeRule(
                g1::Ptr{GEOSGeometry},
                g2::Ptr{GEOSGeometry},
                bnr::Cint,
            )::Cstring
        )
    )
end

function GEOSPrepare(g)
    @timeitccall libgeos.GEOSPrepare(g::Ptr{GEOSGeometry})::Ptr{GEOSPreparedGeometry}
end

function GEOSPreparedGeom_destroy(g)
    @timeitccall libgeos.GEOSPreparedGeom_destroy(g::Ptr{GEOSPreparedGeometry})::Cvoid
end

function GEOSPreparedContains(pg1, g2)
    @timeitccall libgeos.GEOSPreparedContains(
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedContainsProperly(pg1, g2)
    @timeitccall libgeos.GEOSPreparedContainsProperly(
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedCoveredBy(pg1, g2)
    @timeitccall libgeos.GEOSPreparedCoveredBy(
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedCovers(pg1, g2)
    @timeitccall libgeos.GEOSPreparedCovers(
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedCrosses(pg1, g2)
    @timeitccall libgeos.GEOSPreparedCrosses(
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedDisjoint(pg1, g2)
    @timeitccall libgeos.GEOSPreparedDisjoint(
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedIntersects(pg1, g2)
    @timeitccall libgeos.GEOSPreparedIntersects(
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedOverlaps(pg1, g2)
    @timeitccall libgeos.GEOSPreparedOverlaps(
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedTouches(pg1, g2)
    @timeitccall libgeos.GEOSPreparedTouches(
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedWithin(pg1, g2)
    @timeitccall libgeos.GEOSPreparedWithin(
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Cchar
end

function GEOSPreparedNearestPoints(pg1, g2)
    @timeitccall libgeos.GEOSPreparedNearestPoints(
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
    )::Ptr{GEOSCoordSequence}
end

function GEOSPreparedDistance(pg1, g2, dist)
    @timeitccall libgeos.GEOSPreparedDistance(
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
        dist::Ptr{Cdouble},
    )::Cint
end

function GEOSPreparedDistanceWithin(pg1, g2, dist)
    @timeitccall libgeos.GEOSPreparedDistanceWithin(
        pg1::Ptr{GEOSPreparedGeometry},
        g2::Ptr{GEOSGeometry},
        dist::Cdouble,
    )::Cchar
end

function GEOSSTRtree_create(nodeCapacity)
    @timeitccall libgeos.GEOSSTRtree_create(nodeCapacity::Csize_t)::Ptr{GEOSSTRtree}
end

function GEOSSTRtree_insert(tree, g, item)
    @timeitccall libgeos.GEOSSTRtree_insert(
        tree::Ptr{GEOSSTRtree},
        g::Ptr{GEOSGeometry},
        item::Ptr{Cvoid},
    )::Cvoid
end

function GEOSSTRtree_query(tree, g, callback, userdata)
    @timeitccall libgeos.GEOSSTRtree_query(
        tree::Ptr{GEOSSTRtree},
        g::Ptr{GEOSGeometry},
        callback::GEOSQueryCallback,
        userdata::Ptr{Cvoid},
    )::Cvoid
end

function GEOSSTRtree_nearest(tree, geom)
    @timeitccall libgeos.GEOSSTRtree_nearest(
        tree::Ptr{GEOSSTRtree},
        geom::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

function GEOSSTRtree_nearest_generic(tree, item, itemEnvelope, distancefn, userdata)
    @timeitccall libgeos.GEOSSTRtree_nearest_generic(
        tree::Ptr{GEOSSTRtree},
        item::Ptr{Cvoid},
        itemEnvelope::Ptr{GEOSGeometry},
        distancefn::GEOSDistanceCallback,
        userdata::Ptr{Cvoid},
    )::Ptr{Cvoid}
end

function GEOSSTRtree_iterate(tree, callback, userdata)
    @timeitccall libgeos.GEOSSTRtree_iterate(
        tree::Ptr{GEOSSTRtree},
        callback::GEOSQueryCallback,
        userdata::Ptr{Cvoid},
    )::Cvoid
end

function GEOSSTRtree_remove(tree, g, item)
    @timeitccall libgeos.GEOSSTRtree_remove(
        tree::Ptr{GEOSSTRtree},
        g::Ptr{GEOSGeometry},
        item::Ptr{Cvoid},
    )::Cchar
end

function GEOSSTRtree_destroy(tree)
    @timeitccall libgeos.GEOSSTRtree_destroy(tree::Ptr{GEOSSTRtree})::Cvoid
end

function GEOSSegmentIntersection(ax0, ay0, ax1, ay1, bx0, by0, bx1, by1, cx, cy)
    @timeitccall libgeos.GEOSSegmentIntersection(
        ax0::Cdouble,
        ay0::Cdouble,
        ax1::Cdouble,
        ay1::Cdouble,
        bx0::Cdouble,
        by0::Cdouble,
        bx1::Cdouble,
        by1::Cdouble,
        cx::Ptr{Cdouble},
        cy::Ptr{Cdouble},
    )::Cint
end

function GEOSOrientationIndex(Ax, Ay, Bx, By, Px, Py)
    @timeitccall libgeos.GEOSOrientationIndex(
        Ax::Cdouble,
        Ay::Cdouble,
        Bx::Cdouble,
        By::Cdouble,
        Px::Cdouble,
        Py::Cdouble,
    )::Cint
end

function GEOSWKTReader_create()
    @timeitccall libgeos.GEOSWKTReader_create()::Ptr{GEOSWKTReader}
end

function GEOSWKTReader_destroy(reader)
    @timeitccall libgeos.GEOSWKTReader_destroy(reader::Ptr{GEOSWKTReader})::Cvoid
end

function GEOSWKTReader_read(reader, wkt)
    @timeitccall libgeos.GEOSWKTReader_read(
        reader::Ptr{GEOSWKTReader},
        wkt::Cstring,
    )::Ptr{GEOSGeometry}
end

function GEOSWKTReader_setFixStructure(reader, doFix)
    @timeitccall libgeos.GEOSWKTReader_setFixStructure(
        reader::Ptr{GEOSWKTReader},
        doFix::Cchar,
    )::Cvoid
end

function GEOSWKTWriter_create()
    @timeitccall libgeos.GEOSWKTWriter_create()::Ptr{GEOSWKTWriter}
end

function GEOSWKTWriter_destroy(writer)
    @timeitccall libgeos.GEOSWKTWriter_destroy(writer::Ptr{GEOSWKTWriter})::Cvoid
end

function GEOSWKTWriter_write(writer, g)
    string_copy_free(
        @timeitccall(
            libgeos.GEOSWKTWriter_write(
                writer::Ptr{GEOSWKTWriter},
                g::Ptr{GEOSGeometry},
            )::Cstring
        )
    )
end

function GEOSWKTWriter_setTrim(writer, trim)
    @timeitccall libgeos.GEOSWKTWriter_setTrim(writer::Ptr{GEOSWKTWriter}, trim::Cchar)::Cvoid
end

function GEOSWKTWriter_setRoundingPrecision(writer, precision)
    @timeitccall libgeos.GEOSWKTWriter_setRoundingPrecision(
        writer::Ptr{GEOSWKTWriter},
        precision::Cint,
    )::Cvoid
end

function GEOSWKTWriter_setOutputDimension(writer, dim)
    @timeitccall libgeos.GEOSWKTWriter_setOutputDimension(
        writer::Ptr{GEOSWKTWriter},
        dim::Cint,
    )::Cvoid
end

function GEOSWKTWriter_getOutputDimension(writer)
    @timeitccall libgeos.GEOSWKTWriter_getOutputDimension(writer::Ptr{GEOSWKTWriter})::Cint
end

function GEOSWKTWriter_setOld3D(writer, useOld3D)
    @timeitccall libgeos.GEOSWKTWriter_setOld3D(writer::Ptr{GEOSWKTWriter}, useOld3D::Cint)::Cvoid
end

function GEOSWKBReader_create()
    @timeitccall libgeos.GEOSWKBReader_create()::Ptr{GEOSWKBReader}
end

function GEOSWKBReader_destroy(reader)
    @timeitccall libgeos.GEOSWKBReader_destroy(reader::Ptr{GEOSWKBReader})::Cvoid
end

function GEOSWKBReader_setFixStructure(reader, doFix)
    @timeitccall libgeos.GEOSWKBReader_setFixStructure(
        reader::Ptr{GEOSWKBReader},
        doFix::Cchar,
    )::Cvoid
end

function GEOSWKBReader_read(reader, wkb, size)
    @timeitccall libgeos.GEOSWKBReader_read(
        reader::Ptr{GEOSWKBReader},
        wkb::Ptr{Cuchar},
        size::Csize_t,
    )::Ptr{GEOSGeometry}
end

function GEOSWKBReader_readHEX(reader, hex, size)
    @timeitccall libgeos.GEOSWKBReader_readHEX(
        reader::Ptr{GEOSWKBReader},
        hex::Ptr{Cuchar},
        size::Csize_t,
    )::Ptr{GEOSGeometry}
end

function GEOSWKBWriter_create()
    @timeitccall libgeos.GEOSWKBWriter_create()::Ptr{GEOSWKBWriter}
end

function GEOSWKBWriter_destroy(writer)
    @timeitccall libgeos.GEOSWKBWriter_destroy(writer::Ptr{GEOSWKBWriter})::Cvoid
end

function GEOSWKBWriter_write(writer, g, size)
    @timeitccall libgeos.GEOSWKBWriter_write(
        writer::Ptr{GEOSWKBWriter},
        g::Ptr{GEOSGeometry},
        size::Ptr{Csize_t},
    )::Ptr{Cuchar}
end

function GEOSWKBWriter_writeHEX(writer, g, size)
    @timeitccall libgeos.GEOSWKBWriter_writeHEX(
        writer::Ptr{GEOSWKBWriter},
        g::Ptr{GEOSGeometry},
        size::Ptr{Csize_t},
    )::Ptr{Cuchar}
end

function GEOSWKBWriter_getOutputDimension(writer)
    @timeitccall libgeos.GEOSWKBWriter_getOutputDimension(writer::Ptr{GEOSWKBWriter})::Cint
end

function GEOSWKBWriter_setOutputDimension(writer, newDimension)
    @timeitccall libgeos.GEOSWKBWriter_setOutputDimension(
        writer::Ptr{GEOSWKBWriter},
        newDimension::Cint,
    )::Cvoid
end

function GEOSWKBWriter_getByteOrder(writer)
    @timeitccall libgeos.GEOSWKBWriter_getByteOrder(writer::Ptr{GEOSWKBWriter})::Cint
end

function GEOSWKBWriter_setByteOrder(writer, byteOrder)
    @timeitccall libgeos.GEOSWKBWriter_setByteOrder(
        writer::Ptr{GEOSWKBWriter},
        byteOrder::Cint,
    )::Cvoid
end

function GEOSWKBWriter_getFlavor(writer)
    @timeitccall libgeos.GEOSWKBWriter_getFlavor(writer::Ptr{GEOSWKBWriter})::Cint
end

function GEOSWKBWriter_setFlavor(writer, flavor)
    @timeitccall libgeos.GEOSWKBWriter_setFlavor(writer::Ptr{GEOSWKBWriter}, flavor::Cint)::Cvoid
end

function GEOSWKBWriter_getIncludeSRID(writer)
    @timeitccall libgeos.GEOSWKBWriter_getIncludeSRID(writer::Ptr{GEOSWKBWriter})::Cchar
end

function GEOSWKBWriter_setIncludeSRID(writer, writeSRID)
    @timeitccall libgeos.GEOSWKBWriter_setIncludeSRID(
        writer::Ptr{GEOSWKBWriter},
        writeSRID::Cchar,
    )::Cvoid
end

function GEOSGeoJSONReader_create()
    @timeitccall libgeos.GEOSGeoJSONReader_create()::Ptr{GEOSGeoJSONReader}
end

function GEOSGeoJSONReader_destroy(reader)
    @timeitccall libgeos.GEOSGeoJSONReader_destroy(reader::Ptr{GEOSGeoJSONReader})::Cvoid
end

function GEOSGeoJSONReader_readGeometry(reader, geojson)
    @timeitccall libgeos.GEOSGeoJSONReader_readGeometry(
        reader::Ptr{GEOSGeoJSONReader},
        geojson::Cstring,
    )::Ptr{GEOSGeometry}
end

function GEOSGeoJSONWriter_create()
    @timeitccall libgeos.GEOSGeoJSONWriter_create()::Ptr{GEOSGeoJSONWriter}
end

function GEOSGeoJSONWriter_destroy(writer)
    @timeitccall libgeos.GEOSGeoJSONWriter_destroy(writer::Ptr{GEOSGeoJSONWriter})::Cvoid
end

function GEOSGeoJSONWriter_writeGeometry(writer, g, indent)
    string_copy_free(
        @timeitccall(
            libgeos.GEOSGeoJSONWriter_writeGeometry(
                writer::Ptr{GEOSGeoJSONWriter},
                g::Ptr{GEOSGeometry},
                indent::Cint,
            )::Cstring
        )
    )
end

function GEOSSingleSidedBuffer(g, width, quadsegs, joinStyle, mitreLimit, leftSide)
    @timeitccall libgeos.GEOSSingleSidedBuffer(
        g::Ptr{GEOSGeometry},
        width::Cdouble,
        quadsegs::Cint,
        joinStyle::Cint,
        mitreLimit::Cdouble,
        leftSide::Cint,
    )::Ptr{GEOSGeometry}
end

function GEOSSingleSidedBuffer_r(
    handle,
    g,
    width,
    quadsegs,
    joinStyle,
    mitreLimit,
    leftSide,
)
    @timeitccall libgeos.GEOSSingleSidedBuffer_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        width::Cdouble,
        quadsegs::Cint,
        joinStyle::Cint,
        mitreLimit::Cdouble,
        leftSide::Cint,
    )::Ptr{GEOSGeometry}
end

function initGEOS_r(notice_function, error_function)
    @timeitccall libgeos.initGEOS_r(
        notice_function::GEOSMessageHandler,
        error_function::GEOSMessageHandler,
    )::GEOSContextHandle_t
end

function finishGEOS_r(handle)
    @timeitccall libgeos.finishGEOS_r(handle::GEOSContextHandle_t)::Cvoid
end

function GEOSGeomFromWKT_r(handle, wkt)
    @timeitccall libgeos.GEOSGeomFromWKT_r(
        handle::GEOSContextHandle_t,
        wkt::Cstring,
    )::Ptr{GEOSGeometry}
end

function GEOSGeomToWKT_r(handle, g)
    string_copy_free(
        @timeitccall(
            libgeos.GEOSGeomToWKT_r(
                handle::GEOSContextHandle_t,
                g::Ptr{GEOSGeometry},
            )::Cstring
        ),
        handle,
    )
end

function GEOS_getWKBOutputDims_r(handle)
    @timeitccall libgeos.GEOS_getWKBOutputDims_r(handle::GEOSContextHandle_t)::Cint
end

function GEOS_setWKBOutputDims_r(handle, newDims)
    @timeitccall libgeos.GEOS_setWKBOutputDims_r(handle::GEOSContextHandle_t, newDims::Cint)::Cint
end

function GEOS_getWKBByteOrder_r(handle)
    @timeitccall libgeos.GEOS_getWKBByteOrder_r(handle::GEOSContextHandle_t)::Cint
end

function GEOS_setWKBByteOrder_r(handle, byteOrder)
    @timeitccall libgeos.GEOS_setWKBByteOrder_r(
        handle::GEOSContextHandle_t,
        byteOrder::Cint,
    )::Cint
end

function GEOSGeomFromWKB_buf_r(handle, wkb, size)
    @timeitccall libgeos.GEOSGeomFromWKB_buf_r(
        handle::GEOSContextHandle_t,
        wkb::Ptr{Cuchar},
        size::Csize_t,
    )::Ptr{GEOSGeometry}
end

function GEOSGeomToWKB_buf_r(handle, g, size)
    @timeitccall libgeos.GEOSGeomToWKB_buf_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        size::Ptr{Csize_t},
    )::Ptr{Cuchar}
end

function GEOSGeomFromHEX_buf_r(handle, hex, size)
    @timeitccall libgeos.GEOSGeomFromHEX_buf_r(
        handle::GEOSContextHandle_t,
        hex::Ptr{Cuchar},
        size::Csize_t,
    )::Ptr{GEOSGeometry}
end

function GEOSGeomToHEX_buf_r(handle, g, size)
    @timeitccall libgeos.GEOSGeomToHEX_buf_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
        size::Ptr{Csize_t},
    )::Ptr{Cuchar}
end

function GEOSGeomFromWKT(wkt)
    @timeitccall libgeos.GEOSGeomFromWKT(wkt::Cstring)::Ptr{GEOSGeometry}
end

function GEOSGeomToWKT(g)
    string_copy_free(@timeitccall(libgeos.GEOSGeomToWKT(g::Ptr{GEOSGeometry})::Cstring))
end

function GEOS_getWKBOutputDims()
    @timeitccall libgeos.GEOS_getWKBOutputDims()::Cint
end

function GEOS_setWKBOutputDims(newDims)
    @timeitccall libgeos.GEOS_setWKBOutputDims(newDims::Cint)::Cint
end

function GEOS_getWKBByteOrder()
    @timeitccall libgeos.GEOS_getWKBByteOrder()::Cint
end

function GEOS_setWKBByteOrder(byteOrder)
    @timeitccall libgeos.GEOS_setWKBByteOrder(byteOrder::Cint)::Cint
end

function GEOSGeomFromWKB_buf(wkb, size)
    @timeitccall libgeos.GEOSGeomFromWKB_buf(wkb::Ptr{Cuchar}, size::Csize_t)::Ptr{GEOSGeometry}
end

function GEOSGeomToWKB_buf(g, size)
    @timeitccall libgeos.GEOSGeomToWKB_buf(g::Ptr{GEOSGeometry}, size::Ptr{Csize_t})::Ptr{Cuchar}
end

function GEOSGeomFromHEX_buf(hex, size)
    @timeitccall libgeos.GEOSGeomFromHEX_buf(hex::Ptr{Cuchar}, size::Csize_t)::Ptr{GEOSGeometry}
end

function GEOSGeomToHEX_buf(g, size)
    @timeitccall libgeos.GEOSGeomToHEX_buf(g::Ptr{GEOSGeometry}, size::Ptr{Csize_t})::Ptr{Cuchar}
end

function GEOSUnionCascaded(g)
    @timeitccall libgeos.GEOSUnionCascaded(g::Ptr{GEOSGeometry})::Ptr{GEOSGeometry}
end

function GEOSUnionCascaded_r(handle, g)
    @timeitccall libgeos.GEOSUnionCascaded_r(
        handle::GEOSContextHandle_t,
        g::Ptr{GEOSGeometry},
    )::Ptr{GEOSGeometry}
end

const GEOS_VERSION_MAJOR = 3

const GEOS_VERSION_MINOR = 11

const GEOS_VERSION_PATCH = 0

const GEOS_VERSION = "3.11.0"

const GEOS_JTS_PORT = "1.18.0"

const GEOS_CAPI_VERSION_MAJOR = 1

const GEOS_CAPI_VERSION_MINOR = 17

const GEOS_CAPI_VERSION_PATCH = 0

const GEOS_CAPI_VERSION = "3.11.0-CAPI-1.17.0"

const GEOS_CAPI_FIRST_INTERFACE = GEOS_CAPI_VERSION_MAJOR

const GEOS_CAPI_LAST_INTERFACE = GEOS_CAPI_VERSION_MAJOR + GEOS_CAPI_VERSION_MINOR
