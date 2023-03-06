using System;
using System.Collections.Generic;
using UnityEngine;

namespace PoissonDiskSampling
{
    using Random = UnityEngine.Random;

    // The algorithm is from the "Fast Poisson Disk Sampling in Arbitrary Dimensions" paper by Robert Bridson.
    // https://www.cs.ubc.ca/~rbridson/docs/bridson-siggraph07-poissondisk.pdf

    public static class FastPoissonDiskSampling3D
    {
        public const float InvertRootThree = 0.57735026919f; // Becaust three dimension grid.
        public const int DefaultIterationPerPoint = 30;

        #region "Structures"
        private class Settings
        {
            public Vector3 BottomLeftBack;
            public Vector3 TopRightForward;
            public Bounds Dimension;

            public float MinimumDistance;
            public int IterationPerPoint;

            public float CellSize;
            public int GridWidth;
            public int GridHeight;
            public int GridDepth;
        }

        private class Bags
        {
            public Vector3?[,,] Grid;
            public List<Vector3> SamplePoints;
            public List<Vector3> ActivePoints;
        }
        #endregion


        public static Func<bool> StepSampling(Vector3 bottomLeftBack, Vector3 topRightForward, float minimumDistance, int iterationPerPoint, out List<Vector3> points)
        {
            var settings = GetSettings(
                bottomLeftBack,
                topRightForward,
                minimumDistance,
                iterationPerPoint <= 0 ? DefaultIterationPerPoint : iterationPerPoint
            );

            var bags = new Bags()
            {
                // 3次元グリッドを表現する3次元配列を取得する
                Grid = new Vector3?[settings.GridWidth + 1, settings.GridHeight + 1, settings.GridDepth + 1],
                SamplePoints = new List<Vector3>(),
                ActivePoints = new List<Vector3>()
            };

            GetFirstPoint(settings, bags);
            points = bags.SamplePoints;

            Func<bool> loop = null;
            loop = () =>
            {
                Sampling(settings, bags);

                if(bags.ActivePoints.Count <= 0)
                {
                    loop = () => false;
                    return false;
                }

                return true;
            };

            return loop;
        }

        public static List<Vector3> Sampling(Vector3 bottomLeftBack, Vector3 topRightForward, float minimumDistance)
        {
            return Sampling(bottomLeftBack, topRightForward, minimumDistance, DefaultIterationPerPoint);
        }

        public static List<Vector3> Sampling(Vector3 bottomLeftBack, Vector3 topRightForward, float minimumDistance, int iterationPerPoint)
        {
            var points = new List<Vector3>();
            var func = StepSampling(bottomLeftBack, topRightForward, minimumDistance, iterationPerPoint, out points);

            // サンプリングを繰り返す
            var result = true;
            do
            {
                result = func();
            }
            while(result == true);

            return points;
        }

        private static void Sampling(Settings settings, Bags bags)
        {
            // アクティブリストからランダムに点を選ぶ
            var index = Random.Range(0, bags.ActivePoints.Count);
            var point = bags.ActivePoints[index];

            var found = false;
            for(var k = 0; k < settings.IterationPerPoint; k++)
            {
                found = found | GetNextPoint(point, settings, bags);
            }

            if(found == false)
            {
                bags.ActivePoints.RemoveAt(index);
            }
        }

        #region "Algorithm Calculations"
        // point座標を元に、次のサンプリング点を求める
        private static bool GetNextPoint(Vector3 point, Settings set, Bags bags)
        {
            // point座標を中心にr ~ 2rの範囲にあるランダムな点を一点求める
            var p = GetRandPosInSphere(set.MinimumDistance, 2f * set.MinimumDistance) + point;

            // サンプリング空間の範囲外だった場合はサンプリング失敗扱いにする
            if(set.Dimension.Contains(p) == false)
            {
                return false;
            }

            var minimum = set.MinimumDistance * set.MinimumDistance;
            var index = GetGridIndex(p, set);
            var drop = false;

            // 探索するGridの範囲を計算
            var around = 3;
            var fieldMin = new Vector3Int(
                Mathf.Max(0, index.x - around), Mathf.Max(0, index.y - around), Mathf.Max(0, index.z - around)
            );
            var fieldMax = new Vector3Int(
                Mathf.Min(set.GridWidth, index.x + around), Mathf.Min(set.GridHeight, index.y + around), Mathf.Min(set.GridDepth, index.z + around)
            );

            // 周辺のGridに他点が存在しているかを確認
            for(var i = fieldMin.x; i <= fieldMax.x && drop == false; i++)
            {
                for(var j = fieldMin.y; j <= fieldMax.y && drop == false; j++)
                {
                    for(var k = fieldMin.z; k <= fieldMax.z && drop == false; k++)
                    {
                        var q = bags.Grid[i, j, k];
                        if(q.HasValue == true && (q.Value - p).sqrMagnitude <= minimum)
                        {
                            drop = true;
                        }
                    }
                }
            }

            if(drop == true)
            {
                return false;
            }

            // 周辺に他点が存在していないので採用
            bags.SamplePoints.Add(p);
            bags.ActivePoints.Add(p);
            bags.Grid[index.x, index.y, index.z] = p;

            return true;
        }

        // ランダムな座標を一点求める
        private static void GetFirstPoint(Settings set, Bags bags)
        {
            var first = new Vector3(
                Random.Range(set.BottomLeftBack.x, set.TopRightForward.x),
                Random.Range(set.BottomLeftBack.y, set.TopRightForward.y),
                Random.Range(set.BottomLeftBack.z, set.TopRightForward.z)
            );

            var index = GetGridIndex(first, set);

            bags.Grid[index.x, index.y, index.z] = first;
            bags.SamplePoints.Add(first);
            bags.ActivePoints.Add(first);
        }
        #endregion

        #region "Utils"
        // 座標に対応するセルのIndexを取得する
        private static Vector3Int GetGridIndex(Vector3 point, Settings set)
        {
            return new Vector3Int(
                Mathf.FloorToInt((point.x - set.BottomLeftBack.x) / set.CellSize),
                Mathf.FloorToInt((point.y - set.BottomLeftBack.y) / set.CellSize),
                Mathf.FloorToInt((point.z - set.BottomLeftBack.z) / set.CellSize)
            );
        }

        private static Settings GetSettings(Vector3 bottomLeftBack, Vector3 topRightForward, float min, int iteration)
        {
            var dimension = (topRightForward - bottomLeftBack);
            var cell = min * InvertRootThree;

            return new Settings()
            {
                BottomLeftBack = bottomLeftBack,
                TopRightForward = topRightForward,
                Dimension = new Bounds((bottomLeftBack + topRightForward) * 0.5f, dimension),

                MinimumDistance = min,
                IterationPerPoint = iteration,

                CellSize = cell,
                GridWidth = Mathf.CeilToInt(dimension.x / cell),
                GridHeight = Mathf.CeilToInt(dimension.y / cell),
                GridDepth = Mathf.CeilToInt(dimension.z / cell)
            };
        }

        private static Vector3 GetRandPosInSphere(float fieldMin, float fieldMax)
        {
            var radius = Mathf.Sqrt(Random.Range(fieldMin * fieldMin, fieldMax * fieldMax));
            var cos = Random.Range(-1f, 1f);
            var sin = Mathf.Sqrt(1f - cos * cos);
            var phi = Random.Range(0f, Mathf.PI * 2f);

            return new Vector3(radius * sin * Mathf.Cos(phi), radius * sin * Mathf.Sin(phi), radius * cos);
        }
        #endregion
    }
}
